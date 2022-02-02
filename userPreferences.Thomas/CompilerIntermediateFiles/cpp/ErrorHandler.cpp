extern unsigned char D_proc_ERRORHANDLER[];
void proc_ERRORHANDLER( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_ERRORHANDLER);
	if (!ctx->doingAbort) try {
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
