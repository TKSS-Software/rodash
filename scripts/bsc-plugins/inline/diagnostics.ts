import type { Range } from 'brighterscript';
import { DiagnosticSeverity } from 'brighterscript';

export const diagnostics = {
	badAnnotationBody: (range: Range) => ({
		message: 'Inlineable function body must be a single return statement',
		code: 'bad-annotation-body',
		severity: DiagnosticSeverity.Error,
		range: range
	})
};
