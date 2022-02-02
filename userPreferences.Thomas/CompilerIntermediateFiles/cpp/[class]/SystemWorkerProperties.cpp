extern unsigned char D_proc_SystemWorkerProperties_2EonError[];
void proc_SystemWorkerProperties_2EonError( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_SystemWorkerProperties_2EonError);
	if (!ctx->doingAbort) try {
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt KUTF_2D8;
extern Txt Kdata;
extern Txt KdataType;
extern Txt Kencoding;
extern Txt KhideConsole;
extern Txt Ktext;
extern unsigned char D_proc_SystemWorkerProperties_3Aconstructor[];
void proc_SystemWorkerProperties_3Aconstructor( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_SystemWorkerProperties_3Aconstructor);
	if (!ctx->doingAbort) try {
		{
			Obj t0;
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t0.cv(),Kencoding.cv(),KUTF_2D8.cv())) goto _0;
		}
		{
			Obj t1;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t1.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t1.cv(),KdataType.cv(),Ktext.cv())) goto _0;
		}
		{
			Obj t2;
			c.f.fLine=3;
			if (g->Call(ctx,(PCV[]){t2.cv()},0,1470)) goto _0;
			Bool t3;
			t3=Bool(1).get();
			if (g->SetMember(ctx,t2.cv(),KhideConsole.cv(),t3.cv())) goto _0;
		}
		{
			Obj t4;
			c.f.fLine=4;
			if (g->Call(ctx,(PCV[]){t4.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t4.cv(),Kdata.cv(),Parm<Obj>(inParams,inNbParam,1).cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern unsigned char D_proc_SystemWorkerProperties_2EonTerminate[];
void proc_SystemWorkerProperties_2EonTerminate( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_SystemWorkerProperties_2EonTerminate);
	if (!ctx->doingAbort) try {
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern unsigned char D_proc_SystemWorkerProperties_2EonDataError[];
void proc_SystemWorkerProperties_2EonDataError( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_SystemWorkerProperties_2EonDataError);
	if (!ctx->doingAbort) try {
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt Kdata;
extern Txt Ktext;
extern unsigned char D_proc_SystemWorkerProperties_2EonData[];
void proc_SystemWorkerProperties_2EonData( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_SystemWorkerProperties_2EonData);
	if (!ctx->doingAbort) try {
		{
			Variant t0;
			c.f.fLine=1;
			if (g->GetMember(ctx,Parm<Obj>(inParams,inNbParam,2).cv(),Kdata.cv(),t0.cv())) goto _0;
			Long t1;
			if (g->Call(ctx,(PCV[]){t1.cv(),t0.cv()},1,1509)) goto _0;
			Bool t2;
			t2=38==t1.get();
			if (!(t2.get())) goto _2;
		}
		goto _3;
_2:
		{
			Variant t3;
			c.f.fLine=4;
			if (g->GetMember(ctx,Parm<Obj>(inParams,inNbParam,2).cv(),Kdata.cv(),t3.cv())) goto _0;
			Txt t4;
			if (g->Call(ctx,(PCV[]){t4.cv(),t3.cv()},1,10)) goto _0;
			Bool t5;
			t5=g->CompareString(ctx,t4.get(),K.get())!=0;
			if (!(t5.get())) goto _4;
		}
		{
			Obj t6;
			c.f.fLine=5;
			if (g->Call(ctx,(PCV[]){t6.cv()},0,1470)) goto _0;
			Variant t7;
			if (g->GetMember(ctx,t6.cv(),Kdata.cv(),t7.cv())) goto _0;
			Obj t8;
			if (g->Call(ctx,(PCV[]){t8.cv()},0,1470)) goto _0;
			Variant t9;
			if (g->GetMember(ctx,t8.cv(),Kdata.cv(),t9.cv())) goto _0;
			Variant t10;
			if (g->GetMember(ctx,t9.cv(),Ktext.cv(),t10.cv())) goto _0;
			Variant t11;
			if (g->GetMember(ctx,Parm<Obj>(inParams,inNbParam,2).cv(),Kdata.cv(),t11.cv())) goto _0;
			Variant t12;
			if (g->OperationOnAny(ctx,0,t10.cv(),t11.cv(),t12.cv())) goto _0;
			if (g->SetMember(ctx,t7.cv(),Ktext.cv(),t12.cv())) goto _0;
		}
_4:
_3:
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern unsigned char D_proc_SystemWorkerProperties_2EonResponse[];
void proc_SystemWorkerProperties_2EonResponse( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_SystemWorkerProperties_2EonResponse);
	if (!ctx->doingAbort) try {
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
