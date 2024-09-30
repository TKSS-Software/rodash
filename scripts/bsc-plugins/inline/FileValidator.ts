import type { BscFile, FunctionStatement } from 'brighterscript';
import { isCommentStatement } from 'brighterscript';
import { isReturnStatement } from 'brighterscript';
import { BsDiagnostic, ParseMode } from 'brighterscript';
import { AstEditor, createVisitor, isBrsFile, WalkMode } from 'brighterscript';
import { diagnostics } from './diagnostics';

export class FileValidator {
	private editor = new AstEditor();
	public annotatedFunctions = new Map<string, FunctionStatement>();

	public reset() {
		this.editor.undoAll();
		this.editor = new AstEditor();
		this.annotatedFunctions.clear();
	}

	public findAnnotations(file: BscFile) {
		if (isBrsFile(file)) {
			file.ast.walk(createVisitor({
				FunctionStatement: (statement, parent?, owner?, key?) => {
					if (statement.annotations?.find(annotation => annotation.name.toLowerCase() === 'inline')) {
						this.annotatedFunctions.set(statement.getName(ParseMode.BrighterScript).toLowerCase(), statement);
						const bodyStatements = statement.func.body.statements.filter(x => !isCommentStatement(x));

						if (bodyStatements.length !== 1 || !isReturnStatement(bodyStatements[0])) {
							file.addDiagnostic(
								diagnostics.badAnnotationBody(
									bodyStatements[bodyStatements.length - 1]?.range ?? statement.func.range
								)
							);
						}
					}
				}
			}), {
				walkMode: WalkMode.visitStatements
			});
		}
	}
}
