import type { AstEditor, FunctionStatement, BrsFile, BscFile, Identifier, CallExpression, Expression, ReturnStatement, Statement, AssignmentStatement } from 'brighterscript';
import { isBrsFile, Parser, WalkMode, createVisitor, util as bscUtil, isExpressionStatement, GroupingExpression, createToken, TokenKind, isCommentStatement } from 'brighterscript';

import { BrsTranspileState } from 'brighterscript/dist/parser/BrsTranspileState';
import { SourceNode } from 'source-map';

export class FileTranspiler {
	public preprocess(file: BscFile, editor: AstEditor, annotatedFunctions: Map<string, FunctionStatement>) {
		if (isBrsFile(file)) {
			this.walkBscExpressions(file, editor, annotatedFunctions);
		}
	}
	private walkBscExpressions(file: BscFile, editor: AstEditor, annotatedFunctions: Map<string, FunctionStatement>) {
		if (isBrsFile(file)) {
			file.ast.walk(createVisitor({
				CallExpression: (call) => {
					const parts = bscUtil.getAllDottedGetParts(call.callee);
					return (
						this.inlineCall(file, editor, call, parts, annotatedFunctions)
					);
				}
			}), {
				walkMode: WalkMode.visitAllRecursive,
				editor: editor
			});
		}
	}

	private inlineCall(file: BrsFile, editor: AstEditor, call: CallExpression, parts: Identifier[], annotatedFunctions: Map<string, FunctionStatement>) {
		const fullFunctionName = parts?.map(x => x.text).join('.').toLowerCase();
		const annotatedFunction = annotatedFunctions.get(fullFunctionName);
		if (annotatedFunction) {
			const parameterMap = new Map<string, Expression>();

			for (let index = 0; index < annotatedFunction.func.parameters.length; index++) {
				const annotatedParameter = annotatedFunction.func.parameters[index];
				const callArgument = call.args[index] ?? annotatedParameter?.defaultValue;
				parameterMap.set(annotatedParameter.name.text, callArgument);
			}

			const clonedStatement = this.cloneStatement<ReturnStatement>(annotatedFunction.func.body.statements.filter(x => !isCommentStatement(x))[0], file);
			clonedStatement.walk(createVisitor({
				VariableExpression: (variable, parent?, owner?, key?) => {
					const arg = parameterMap.get(variable.name.text);
					if (arg) {
						return this.cloneExpression(arg, file);
					}
				}
			}), {
				walkMode: WalkMode.visitAllRecursive,
				editor: editor
			});

			if (isExpressionStatement(call.parent)) {
				return clonedStatement.value;
			} else {
				return new GroupingExpression({
					left: createToken(TokenKind.LeftParen),
					right: createToken(TokenKind.RightParen)
				}, clonedStatement.value);
			}
		}
	}

	private cloneStatement<T>(statement: Statement, file: BrsFile) {
		return statement.clone() as T;
	}

	private cloneExpression<T = Expression>(expression: Expression, file: BrsFile) {
		const newCode = new SourceNode(null, null, null, [
			(expression.transpile(new BrsTranspileState(file)) as any)
		]).toString();
		return (Parser.parse(`__thing = ${newCode}`).ast.statements[0] as AssignmentStatement).value as T;
	}
}

