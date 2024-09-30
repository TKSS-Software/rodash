import type { AstEditor, CompilerPlugin, FileObj, Program, ProgramBuilder, TranspileObj } from 'brighterscript';
import { FileValidator } from './FileValidator';
import { FileTranspiler } from './inline';

export class Plugin implements CompilerPlugin {
	name = 'bsc-plugin-inline';

	private fileValidator = new FileValidator();
	private fileTranspiler = new FileTranspiler();
	beforeProgramTranspile(program: Program, entries: TranspileObj[], editor: AstEditor) {
		console.log("HEY IM HERE");	
		for (const entry of entries) {
			this.fileTranspiler.preprocess(entry.file, editor, this.fileValidator.annotatedFunctions);
		}
	}

	private builder: ProgramBuilder;
	private logger: typeof ProgramBuilder.prototype.logger = console as any;
	public beforeProgramCreate(builder: ProgramBuilder) {
		this.builder = builder;
		this.logger = this.builder.logger;
	}

	afterProgramValidate(program: Program) {
		this.fileValidator.reset();

		// Get a map of all annotated functions
		for (const file of Object.values(program.files)) {
			this.fileValidator.findAnnotations(file);
		}
	}
}