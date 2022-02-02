extern Txt K;
extern Txt K_2Dssl_20;
extern Txt K_3A;
extern Txt K_40;
extern Txt K__host;
extern Txt K__password;
extern Txt K__protocoll;
extern Txt K__user;
extern Txt Kftp_3A_2F_2F;
extern Txt Kftps;
extern unsigned char D_proc_FileTransfer_2E__buildURL[];
void proc_FileTransfer_2E__buildURL( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2E__buildURL);
	if (!ctx->doingAbort) try {
		new ( outResult) Txt();
		Res<Txt>(outResult)=Kftp_3A_2F_2F.get();
		{
			Obj t0;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			Variant t1;
			if (g->GetMember(ctx,t0.cv(),K__user.cv(),t1.cv())) goto _0;
			Bool t2;
			if (g->OperationOnAny(ctx,7,t1.cv(),K.cv(),t2.cv())) goto _0;
			if (!(t2.get())) goto _2;
		}
		{
			Obj t3;
			c.f.fLine=3;
			if (g->Call(ctx,(PCV[]){t3.cv()},0,1470)) goto _0;
			Variant t4;
			if (g->GetMember(ctx,t3.cv(),K__user.cv(),t4.cv())) goto _0;
			Variant t5;
			if (g->OperationOnAny(ctx,0,t4.cv(),K_3A.cv(),t5.cv())) goto _0;
			Obj t6;
			if (g->Call(ctx,(PCV[]){t6.cv()},0,1470)) goto _0;
			Variant t7;
			if (g->GetMember(ctx,t6.cv(),K__password.cv(),t7.cv())) goto _0;
			Variant t8;
			if (g->OperationOnAny(ctx,0,t5.cv(),t7.cv(),t8.cv())) goto _0;
			Variant t9;
			if (g->OperationOnAny(ctx,0,t8.cv(),K_40.cv(),t9.cv())) goto _0;
			Variant t10;
			if (g->OperationOnAny(ctx,0,Res<Txt>(outResult).cv(),t9.cv(),t10.cv())) goto _0;
			Txt t11;
			if (!g->GetValue(ctx,(PCV[]){t11.cv(),t10.cv(),nullptr})) goto _0;
			Res<Txt>(outResult)=t11.get();
		}
_2:
		{
			Obj t12;
			c.f.fLine=5;
			if (g->Call(ctx,(PCV[]){t12.cv()},0,1470)) goto _0;
			Variant t13;
			if (g->GetMember(ctx,t12.cv(),K__host.cv(),t13.cv())) goto _0;
			Variant t14;
			if (g->OperationOnAny(ctx,0,Res<Txt>(outResult).cv(),t13.cv(),t14.cv())) goto _0;
			Txt t15;
			if (!g->GetValue(ctx,(PCV[]){t15.cv(),t14.cv(),nullptr})) goto _0;
			Res<Txt>(outResult)=t15.get();
		}
		{
			Obj t16;
			c.f.fLine=6;
			if (g->Call(ctx,(PCV[]){t16.cv()},0,1470)) goto _0;
			Variant t17;
			if (g->GetMember(ctx,t16.cv(),K__protocoll.cv(),t17.cv())) goto _0;
			Bool t18;
			if (g->OperationOnAny(ctx,6,t17.cv(),Kftps.cv(),t18.cv())) goto _0;
			if (!(t18.get())) goto _3;
		}
		{
			Txt t19;
			g->AddString(K_2Dssl_20.get(),Res<Txt>(outResult).get(),t19.get());
			Res<Txt>(outResult)=t19.get();
		}
_3:
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt KSystemWorker;
extern Txt K_20;
extern Txt K_20_2D_2Dmax_2Dtime_20;
extern Txt K__connectTimeout;
extern Txt K__maxTime;
extern Txt K__prefix;
extern Txt Kcurl;
extern Txt Kcurl_3A_20;
extern Txt Kdata;
extern Txt Kerror;
extern Txt Knew;
extern Txt KonData;
extern Txt Kresponse;
extern Txt KresponseError;
extern Txt Ksource;
extern Txt Ksuccess;
extern Txt Kwait;
extern Txt k6NNkZIyXlnA;
extern Txt k8vJ58cnQN2o;
extern Txt kSbGirxthesE;
extern unsigned char D_proc_FileTransfer_2E__runWorker[];
void proc_FileTransfer_2E__runWorker( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2E__runWorker);
	if (!ctx->doingAbort) try {
		Txt lcommand;
		Obj lworker;
		Txt lpath;
		Variant lworkerpara;
		Long lpos;
		Txt lold;
		new ( outResult) Obj();
		{
			Obj t0;
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1710)) goto _0;
			Variant t1;
			if (g->GetMember(ctx,t0.cv(),k6NNkZIyXlnA.cv(),t1.cv())) goto _0;
			Obj t2;
			if (g->Call(ctx,(PCV[]){t2.cv()},0,1470)) goto _0;
			Variant t3;
			if (g->GetMember(ctx,t2.cv(),KonData.cv(),t3.cv())) goto _0;
			Variant t4;
			if (g->Call(ctx,(PCV[]){t4.cv(),t1.cv(),Knew.cv(),t3.cv()},3,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t4.cv(),lworkerpara.cv(),nullptr})) goto _0;
		}
		lpath=Kcurl.get();
		{
			Obj t5;
			c.f.fLine=4;
			if (g->Call(ctx,(PCV[]){t5.cv()},0,1470)) goto _0;
			Variant t6;
			if (g->GetMember(ctx,t5.cv(),K__prefix.cv(),t6.cv())) goto _0;
			Bool t7;
			if (g->OperationOnAny(ctx,7,t6.cv(),Value_null().cv(),t7.cv())) goto _0;
			if (!(t7.get())) goto _2;
		}
		{
			Obj t8;
			c.f.fLine=5;
			if (g->Call(ctx,(PCV[]){t8.cv()},0,1470)) goto _0;
			Variant t9;
			if (g->GetMember(ctx,t8.cv(),K__prefix.cv(),t9.cv())) goto _0;
			Variant t10;
			if (g->OperationOnAny(ctx,0,K_20.cv(),t9.cv(),t10.cv())) goto _0;
			Variant t11;
			if (g->OperationOnAny(ctx,0,lpath.cv(),t10.cv(),t11.cv())) goto _0;
			Txt t12;
			if (!g->GetValue(ctx,(PCV[]){t12.cv(),t11.cv(),nullptr})) goto _0;
			lpath=t12.get();
		}
_2:
		{
			Obj t13;
			c.f.fLine=7;
			if (g->Call(ctx,(PCV[]){t13.cv()},0,1470)) goto _0;
			Variant t14;
			if (g->GetMember(ctx,t13.cv(),K__connectTimeout.cv(),t14.cv())) goto _0;
			Bool t15;
			if (g->OperationOnAny(ctx,7,t14.cv(),Value_null().cv(),t15.cv())) goto _0;
			if (!(t15.get())) goto _3;
		}
		{
			Obj t16;
			c.f.fLine=8;
			if (g->Call(ctx,(PCV[]){t16.cv()},0,1470)) goto _0;
			Variant t17;
			if (g->GetMember(ctx,t16.cv(),K__connectTimeout.cv(),t17.cv())) goto _0;
			Txt t18;
			if (g->Call(ctx,(PCV[]){t18.cv(),t17.cv()},1,10)) goto _0;
			Txt t19;
			g->AddString(k8vJ58cnQN2o.get(),t18.get(),t19.get());
			Txt t20;
			g->AddString(lpath.get(),t19.get(),t20.get());
			lpath=t20.get();
		}
_3:
		{
			Obj t21;
			c.f.fLine=10;
			if (g->Call(ctx,(PCV[]){t21.cv()},0,1470)) goto _0;
			Variant t22;
			if (g->GetMember(ctx,t21.cv(),K__maxTime.cv(),t22.cv())) goto _0;
			Bool t23;
			if (g->OperationOnAny(ctx,7,t22.cv(),Value_null().cv(),t23.cv())) goto _0;
			if (!(t23.get())) goto _4;
		}
		{
			Obj t24;
			c.f.fLine=11;
			if (g->Call(ctx,(PCV[]){t24.cv()},0,1470)) goto _0;
			Variant t25;
			if (g->GetMember(ctx,t24.cv(),K__maxTime.cv(),t25.cv())) goto _0;
			Txt t26;
			if (g->Call(ctx,(PCV[]){t26.cv(),t25.cv()},1,10)) goto _0;
			Txt t27;
			g->AddString(K_20_2D_2Dmax_2Dtime_20.get(),t26.get(),t27.get());
			Txt t28;
			g->AddString(lpath.get(),t27.get(),t28.get());
			lpath=t28.get();
		}
_4:
		{
			Txt t29;
			g->AddString(lpath.get(),K_20.get(),t29.get());
			g->AddString(t29.get(),Parm<Txt>(inParams,inNbParam,1).get(),lcommand.get());
		}
		{
			Txt t31;
			c.f.fLine=16;
			if (g->Call(ctx,(PCV[]){t31.cv()},0,704)) goto _0;
			g->Check(ctx);
			lold=t31.get();
		}
		goto _5;
_5:
		{
			Obj t32;
			c.f.fLine=17;
			if (g->Call(ctx,(PCV[]){t32.cv(),Long(0).cv(),(CV*)-1,nullptr,Long(1).cv(),Long(0).cv()},5,1597)) goto _0;
			g->Check(ctx);
			Variant t33;
			if (g->GetMember(ctx,t32.cv(),Ksource.cv(),t33.cv())) goto _0;
			if (g->Call(ctx,(PCV[]){nullptr,t33.cv()},1,155)) goto _0;
		}
		{
			Obj t34;
			c.f.fLine=18;
			if (g->Call(ctx,(PCV[]){t34.cv()},0,1709)) goto _0;
			Variant t35;
			if (g->GetMember(ctx,t34.cv(),KSystemWorker.cv(),t35.cv())) goto _0;
			Variant t36;
			if (g->Call(ctx,(PCV[]){t36.cv(),t35.cv(),Knew.cv(),lcommand.cv(),lworkerpara.cv()},4,1498)) goto _0;
			g->Check(ctx);
			Obj t37;
			if (!g->GetValue(ctx,(PCV[]){t37.cv(),t36.cv(),nullptr})) goto _0;
			lworker=t37.get();
		}
		{
			Bool t38;
			t38=!lworker.isNull();
			if (!(t38.get())) goto _6;
		}
		c.f.fLine=20;
		if (g->Call(ctx,(PCV[]){nullptr,lworker.cv(),Kwait.cv()},2,1500)) goto _0;
		g->Check(ctx);
		{
			Variant t39;
			c.f.fLine=21;
			if (g->GetMember(ctx,lworker.cv(),KresponseError.cv(),t39.cv())) goto _0;
			Bool t40;
			if (g->OperationOnAny(ctx,7,t39.cv(),Value_null().cv(),t40.cv())) goto _0;
			Bool t41;
			t41=t40.get();
			if (!(t40.get())) goto _7;
			{
				Variant t42;
				if (g->GetMember(ctx,lworker.cv(),KresponseError.cv(),t42.cv())) goto _0;
				Bool t43;
				if (g->OperationOnAny(ctx,7,t42.cv(),K.cv(),t43.cv())) goto _0;
				t41=t43.get();
			}
_7:
			if (!(t41.get())) goto _8;
		}
		{
			Variant t44;
			c.f.fLine=22;
			if (g->GetMember(ctx,lworker.cv(),KresponseError.cv(),t44.cv())) goto _0;
			Bool t45;
			t45=Bool(0).get();
			Obj t46;
			if (g->Call(ctx,(PCV[]){t46.cv(),KresponseError.cv(),t44.cv(),Ksuccess.cv(),t45.cv()},4,1471)) goto _0;
			g->Check(ctx);
			Res<Obj>(outResult)=t46.get();
		}
		{
			Variant t47;
			c.f.fLine=23;
			if (g->GetMember(ctx,lworker.cv(),KresponseError.cv(),t47.cv())) goto _0;
			Long t48;
			if (g->Call(ctx,(PCV[]){t48.cv(),Kcurl_3A_20.cv(),t47.cv(),Ref((optyp)3).cv()},3,15)) goto _0;
			lpos=t48.get();
		}
		if (0>=lpos.get()) goto _9;
		{
			Variant t50;
			c.f.fLine=25;
			if (g->GetMember(ctx,lworker.cv(),KresponseError.cv(),t50.cv())) goto _0;
			Long t51;
			t51=lpos.get()+6;
			Variant t52;
			if (g->Call(ctx,(PCV[]){t52.cv(),t50.cv(),t51.cv()},2,12)) goto _0;
			Txt t53;
			if (g->Call(ctx,(PCV[]){t53.cv(),Long(10).cv()},1,90)) goto _0;
			Txt t54;
			if (!g->GetValue(ctx,(PCV[]){t54.cv(),t52.cv(),nullptr})) goto _0;
			Txt t55;
			if (g->Call(ctx,(PCV[]){t55.cv(),t54.cv(),t53.cv(),K.cv()},3,233)) goto _0;
			if (g->SetMember(ctx,Res<Obj>(outResult).cv(),Kerror.cv(),t55.cv())) goto _0;
		}
		goto _10;
_9:
		{
			Variant t56;
			c.f.fLine=27;
			if (g->GetMember(ctx,lworker.cv(),Kresponse.cv(),t56.cv())) goto _0;
			Bool t57;
			if (g->OperationOnAny(ctx,7,t56.cv(),Value_null().cv(),t57.cv())) goto _0;
			Bool t58;
			t58=t57.get();
			if (!(t57.get())) goto _11;
			{
				Variant t59;
				if (g->GetMember(ctx,lworker.cv(),Kresponse.cv(),t59.cv())) goto _0;
				Bool t60;
				if (g->OperationOnAny(ctx,7,t59.cv(),K.cv(),t60.cv())) goto _0;
				t58=t60.get();
			}
_11:
			if (!(t58.get())) goto _12;
		}
		{
			Variant t61;
			c.f.fLine=28;
			if (g->GetMember(ctx,lworker.cv(),Kresponse.cv(),t61.cv())) goto _0;
			Bool t62;
			t62=Bool(1).get();
			Obj t63;
			if (g->Call(ctx,(PCV[]){t63.cv(),Kdata.cv(),t61.cv(),Ksuccess.cv(),t62.cv()},4,1471)) goto _0;
			g->Check(ctx);
			Res<Obj>(outResult)=t63.get();
		}
		goto _13;
_12:
		{
			Variant t64;
			c.f.fLine=30;
			if (g->GetMember(ctx,lworker.cv(),KresponseError.cv(),t64.cv())) goto _0;
			Bool t65;
			t65=Bool(1).get();
			Obj t66;
			if (g->Call(ctx,(PCV[]){t66.cv(),Kdata.cv(),t64.cv(),Ksuccess.cv(),t65.cv()},4,1471)) goto _0;
			g->Check(ctx);
			Res<Obj>(outResult)=t66.get();
		}
_13:
_10:
		goto _14;
_8:
		{
			Variant t67;
			c.f.fLine=34;
			if (g->GetMember(ctx,lworker.cv(),Kresponse.cv(),t67.cv())) goto _0;
			Bool t68;
			t68=Bool(1).get();
			Obj t69;
			if (g->Call(ctx,(PCV[]){t69.cv(),Kdata.cv(),t67.cv(),Ksuccess.cv(),t68.cv()},4,1471)) goto _0;
			g->Check(ctx);
			Res<Obj>(outResult)=t69.get();
		}
_14:
		goto _15;
_6:
		{
			Bool t70;
			t70=Bool(0).get();
			Obj t71;
			c.f.fLine=37;
			if (g->Call(ctx,(PCV[]){t71.cv(),Ksuccess.cv(),t70.cv(),KresponseError.cv(),kSbGirxthesE.cv()},4,1471)) goto _0;
			g->Check(ctx);
			Res<Obj>(outResult)=t71.get();
		}
_15:
		c.f.fLine=39;
		if (g->Call(ctx,(PCV[]){nullptr,lold.cv()},1,155)) goto _0;
		g->Check(ctx);
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K__maxTime;
extern unsigned char D_proc_FileTransfer_2EsetmaxTime[];
void proc_FileTransfer_2EsetmaxTime( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EsetmaxTime);
	if (!ctx->doingAbort) try {
		{
			Obj t0;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t0.cv(),K__maxTime.cv(),Parm<Long>(inParams,inNbParam,1).cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt K_20;
extern Txt K_2DT_20;
extern Txt K_2D_2Dappend_20;
extern Txt K_2F;
extern Txt K__buildURL;
extern Txt K__runWorker;
extern Txt kN91nPhC5x8Q;
extern Txt kb$zZwOxM6rY;
extern Txt kunWRpvD_pMI;
extern unsigned char D_proc_FileTransfer_2Eupload[];
void proc_FileTransfer_2Eupload( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2Eupload);
	if (!ctx->doingAbort) try {
		Txt lurl;
		new ( outResult) Obj();
		{
			Bool t0;
			t0=ctx->withAssert;
			if (!(t0.get())) goto _2;
		}
		{
			Bool t1;
			t1=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,1).get(),K.get())!=0;
			Bool t2;
			t2=t1.get();
			c.f.fLine=6;
			if (g->Call(ctx,(PCV[]){nullptr,t2.cv(),kb$zZwOxM6rY.cv()},2,1129)) goto _0;
			g->Check(ctx);
		}
_2:
		{
			Bool t3;
			t3=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,2).get(),K.get())==0;
			if (!(t3.get())) goto _3;
		}
		Parm<Txt>(inParams,inNbParam,2)=K_2F.get();
_3:
		{
			Obj t4;
			c.f.fLine=10;
			if (g->Call(ctx,(PCV[]){t4.cv()},0,1470)) goto _0;
			Variant t5;
			if (g->Call(ctx,(PCV[]){t5.cv(),t4.cv(),K__buildURL.cv()},2,1498)) goto _0;
			g->Check(ctx);
			Txt t6;
			if (!g->GetValue(ctx,(PCV[]){t6.cv(),t5.cv(),nullptr})) goto _0;
			lurl=t6.get();
		}
		if (!(Parm<Bool>(inParams,inNbParam,3).get())) goto _4;
		{
			Txt t7;
			g->AddString(K_2D_2Dappend_20.get(),lurl.get(),t7.get());
			lurl=t7.get();
		}
_4:
		{
			Obj t8;
			c.f.fLine=14;
			if (g->Call(ctx,(PCV[]){t8.cv()},0,1470)) goto _0;
			Variant t9;
			if (g->GetMember(ctx,t8.cv(),kunWRpvD_pMI.cv(),t9.cv())) goto _0;
			Bool t10;
			if (g->OperationOnAny(ctx,7,t9.cv(),Value_null().cv(),t10.cv())) goto _0;
			Variant t11;
			if (!g->SetValue(ctx,(PCV[]){t10.cv(),t11.cv(),nullptr})) goto _0;
			if (!(t10.get())) goto _5;
			{
				Obj t12;
				if (g->Call(ctx,(PCV[]){t12.cv()},0,1470)) goto _0;
				if (g->GetMember(ctx,t12.cv(),kunWRpvD_pMI.cv(),t11.cv())) goto _0;
			}
_5:
			Bool t14;
			if (!g->GetValue(ctx,(PCV[]){t14.cv(),t11.cv(),nullptr})) goto _0;
			if (!(t14.get())) goto _6;
		}
		{
			Txt t15;
			g->AddString(kN91nPhC5x8Q.get(),lurl.get(),t15.get());
			lurl=t15.get();
		}
_6:
		{
			Txt t16;
			g->AddString(K_2DT_20.get(),Parm<Txt>(inParams,inNbParam,1).get(),t16.get());
			Txt t17;
			g->AddString(t16.get(),K_20.get(),t17.get());
			Txt t18;
			g->AddString(t17.get(),lurl.get(),t18.get());
			g->AddString(t18.get(),Parm<Txt>(inParams,inNbParam,2).get(),lurl.get());
		}
		{
			Obj t20;
			c.f.fLine=18;
			if (g->Call(ctx,(PCV[]){t20.cv()},0,1470)) goto _0;
			Variant t21;
			if (g->Call(ctx,(PCV[]){t21.cv(),t20.cv(),K__runWorker.cv(),lurl.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Obj t22;
			if (!g->GetValue(ctx,(PCV[]){t22.cv(),t21.cv(),nullptr})) goto _0;
			Res<Obj>(outResult)=t22.get();
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K__prefix;
extern unsigned char D_proc_FileTransfer_2EsetCurlPrefix[];
void proc_FileTransfer_2EsetCurlPrefix( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EsetCurlPrefix);
	if (!ctx->doingAbort) try {
		{
			Obj t0;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t0.cv(),K__prefix.cv(),Parm<Txt>(inParams,inNbParam,1).cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt kDr9Rqsgnq_g;
extern unsigned char D_proc_FileTransfer_2EsetAutoCreateLocalDirectory[];
void proc_FileTransfer_2EsetAutoCreateLocalDirectory( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EsetAutoCreateLocalDirectory);
	if (!ctx->doingAbort) try {
		{
			Obj t0;
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			Bool t1;
			t1=Parm<Bool>(inParams,inNbParam,1).get();
			if (g->SetMember(ctx,t0.cv(),kDr9Rqsgnq_g.cv(),t1.cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt K_20_2D_2Doutput_2Ddir_20;
extern Txt K_20_2Do_20;
extern Txt K_2D_2Dcreate_2Ddirs_20;
extern Txt K_40_2F;
extern Txt K__buildURL;
extern Txt K__runWorker;
extern Txt kDr9Rqsgnq_g;
extern Txt kb$zZwOxM6rY;
extern Txt kbz1SxVn_6GE;
extern Txt kxwk18YF8TBQ;
extern unsigned char D_proc_FileTransfer_2Edownload[];
void proc_FileTransfer_2Edownload( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2Edownload);
	if (!ctx->doingAbort) try {
		Txt lurl;
		new ( outResult) Obj();
		{
			Bool t0;
			t0=ctx->withAssert;
			if (!(t0.get())) goto _2;
		}
		{
			Bool t1;
			t1=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,1).get(),K.get())!=0;
			Bool t2;
			t2=t1.get();
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){nullptr,t2.cv(),kb$zZwOxM6rY.cv()},2,1129)) goto _0;
			g->Check(ctx);
		}
_2:
		{
			Bool t3;
			t3=ctx->withAssert;
			if (!(t3.get())) goto _3;
		}
		{
			Bool t4;
			t4=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,2).get(),K.get())!=0;
			Bool t5;
			t5=t4.get();
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){nullptr,t5.cv(),kxwk18YF8TBQ.cv()},2,1129)) goto _0;
			g->Check(ctx);
		}
_3:
		{
			Obj t6;
			c.f.fLine=3;
			if (g->Call(ctx,(PCV[]){t6.cv()},0,1470)) goto _0;
			Variant t7;
			if (g->Call(ctx,(PCV[]){t7.cv(),t6.cv(),K__buildURL.cv()},2,1498)) goto _0;
			g->Check(ctx);
			Txt t8;
			if (!g->GetValue(ctx,(PCV[]){t8.cv(),t7.cv(),nullptr})) goto _0;
			lurl=t8.get();
		}
		{
			Obj t9;
			c.f.fLine=4;
			if (g->Call(ctx,(PCV[]){t9.cv()},0,1470)) goto _0;
			Variant t10;
			if (g->GetMember(ctx,t9.cv(),kDr9Rqsgnq_g.cv(),t10.cv())) goto _0;
			Bool t11;
			if (g->OperationOnAny(ctx,7,t10.cv(),Value_null().cv(),t11.cv())) goto _0;
			Variant t12;
			if (!g->SetValue(ctx,(PCV[]){t11.cv(),t12.cv(),nullptr})) goto _0;
			if (!(t11.get())) goto _4;
			{
				Obj t13;
				if (g->Call(ctx,(PCV[]){t13.cv()},0,1470)) goto _0;
				if (g->GetMember(ctx,t13.cv(),kDr9Rqsgnq_g.cv(),t12.cv())) goto _0;
			}
_4:
			Bool t15;
			if (!g->GetValue(ctx,(PCV[]){t15.cv(),t12.cv(),nullptr})) goto _0;
			if (!(t15.get())) goto _5;
		}
		{
			Txt t16;
			g->AddString(K_2D_2Dcreate_2Ddirs_20.get(),lurl.get(),t16.get());
			lurl=t16.get();
		}
_5:
		{
			Bool t17;
			t17=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,2).get(),K_40_2F.get())==0;
			if (!(t17.get())) goto _6;
		}
		{
			Txt t18;
			g->AddString(K_20_2D_2Doutput_2Ddir_20.get(),Parm<Txt>(inParams,inNbParam,2).get(),t18.get());
			Txt t19;
			g->AddString(t18.get(),kbz1SxVn_6GE.get(),t19.get());
			Txt t20;
			g->AddString(t19.get(),lurl.get(),t20.get());
			g->AddString(t20.get(),Parm<Txt>(inParams,inNbParam,1).get(),lurl.get());
		}
		goto _7;
_6:
		{
			Txt t22;
			g->AddString(K_20_2Do_20.get(),Parm<Txt>(inParams,inNbParam,2).get(),t22.get());
			Txt t23;
			g->AddString(t22.get(),lurl.get(),t23.get());
			g->AddString(t23.get(),Parm<Txt>(inParams,inNbParam,1).get(),lurl.get());
		}
_7:
		{
			Obj t25;
			c.f.fLine=12;
			if (g->Call(ctx,(PCV[]){t25.cv()},0,1470)) goto _0;
			Variant t26;
			if (g->Call(ctx,(PCV[]){t26.cv(),t25.cv(),K__runWorker.cv(),lurl.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Obj t27;
			if (!g->GetValue(ctx,(PCV[]){t27.cv(),t26.cv(),nullptr})) goto _0;
			Res<Obj>(outResult)=t27.get();
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt kunWRpvD_pMI;
extern unsigned char D_proc_FileTransfer_2EsetAutoCreateRemoteDirectory[];
void proc_FileTransfer_2EsetAutoCreateRemoteDirectory( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EsetAutoCreateRemoteDirectory);
	if (!ctx->doingAbort) try {
		{
			Obj t0;
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			Bool t1;
			t1=Parm<Bool>(inParams,inNbParam,1).get();
			if (g->SetMember(ctx,t0.cv(),kunWRpvD_pMI.cv(),t1.cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K__connectTimeout;
extern unsigned char D_proc_FileTransfer_2EsetConnectTimeout[];
void proc_FileTransfer_2EsetConnectTimeout( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EsetConnectTimeout);
	if (!ctx->doingAbort) try {
		{
			Obj t0;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t0.cv(),K__connectTimeout.cv(),Parm<Long>(inParams,inNbParam,1).cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt K__buildURL;
extern Txt K__runWorker;
extern Txt k87Ybvxs5Ve4;
extern Txt kxwk18YF8TBQ;
extern unsigned char D_proc_FileTransfer_2EcreateDirectory[];
void proc_FileTransfer_2EcreateDirectory( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EcreateDirectory);
	if (!ctx->doingAbort) try {
		Txt lurl;
		new ( outResult) Obj();
		{
			Bool t0;
			t0=ctx->withAssert;
			if (!(t0.get())) goto _2;
		}
		{
			Bool t1;
			t1=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,1).get(),K.get())!=0;
			Bool t2;
			t2=t1.get();
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){nullptr,t2.cv(),kxwk18YF8TBQ.cv()},2,1129)) goto _0;
			g->Check(ctx);
		}
_2:
		{
			Obj t3;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t3.cv()},0,1470)) goto _0;
			Variant t4;
			if (g->Call(ctx,(PCV[]){t4.cv(),t3.cv(),K__buildURL.cv()},2,1498)) goto _0;
			g->Check(ctx);
			Txt t5;
			if (!g->GetValue(ctx,(PCV[]){t5.cv(),t4.cv(),nullptr})) goto _0;
			lurl=t5.get();
		}
		{
			Txt t6;
			g->AddString(lurl.get(),Parm<Txt>(inParams,inNbParam,1).get(),t6.get());
			g->AddString(t6.get(),k87Ybvxs5Ve4.get(),lurl.get());
		}
		{
			Obj t8;
			c.f.fLine=4;
			if (g->Call(ctx,(PCV[]){t8.cv()},0,1470)) goto _0;
			Variant t9;
			if (g->Call(ctx,(PCV[]){t9.cv(),t8.cv(),K__runWorker.cv(),lurl.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Obj t10;
			if (!g->GetValue(ctx,(PCV[]){t10.cv(),t9.cv(),nullptr})) goto _0;
			Res<Obj>(outResult)=t10.get();
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt KApr;
extern Txt KAug;
extern Txt KDec;
extern Txt KFeb;
extern Txt KJan;
extern Txt KJul;
extern Txt KJun;
extern Txt KMar;
extern Txt KMay;
extern Txt KNov;
extern Txt KOct;
extern Txt KSep;
extern Txt K_20;
extern Txt K_2F;
extern Txt K_3A;
extern Txt K__buildURL;
extern Txt K__runWorker;
extern Txt Kaccess;
extern Txt Kdata;
extern Txt Kdate;
extern Txt Kerror;
extern Txt Kgroup;
extern Txt KindexOf;
extern Txt Klength;
extern Txt Klist;
extern Txt Kname;
extern Txt Kowner;
extern Txt Kpush;
extern Txt Ksize;
extern Txt Ksuccess;
extern Txt Ktime;
extern Txt Ktype;
extern Txt kiXKWqWzSOCM;
extern unsigned char D_proc_FileTransfer_2EgetDirectoryListing[];
void proc_FileTransfer_2EgetDirectoryListing( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2EgetDirectoryListing);
	if (!ctx->doingAbort) try {
		Col llineitems;
		Long lday;
		Long lyear;
		Date ldate;
		Obj ldiritem;
		Col ldatecol;
		Col lcol;
		Obj l__4D__auto__iter__0;
		Txt lline;
		Time ltime;
		Long lmonth;
		Variant lurl;
		new ( outResult) Obj();
		{
			Bool t0;
			t0=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,1).get(),K.get())==0;
			if (!(t0.get())) goto _2;
		}
		Parm<Txt>(inParams,inNbParam,1)=K_2F.get();
_2:
		{
			Obj t1;
			c.f.fLine=4;
			if (g->Call(ctx,(PCV[]){t1.cv()},0,1470)) goto _0;
			Variant t2;
			if (g->Call(ctx,(PCV[]){t2.cv(),t1.cv(),K__buildURL.cv()},2,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t2.cv(),lurl.cv(),nullptr})) goto _0;
		}
		{
			Obj t3;
			c.f.fLine=5;
			if (g->Call(ctx,(PCV[]){t3.cv()},0,1470)) goto _0;
			Variant t4;
			if (g->Call(ctx,(PCV[]){t4.cv(),t3.cv(),K__runWorker.cv(),lurl.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Obj t5;
			if (!g->GetValue(ctx,(PCV[]){t5.cv(),t4.cv(),nullptr})) goto _0;
			Res<Obj>(outResult)=t5.get();
		}
		{
			Variant t6;
			c.f.fLine=6;
			if (g->GetMember(ctx,Res<Obj>(outResult).cv(),Ksuccess.cv(),t6.cv())) goto _0;
			Bool t7;
			if (!g->GetValue(ctx,(PCV[]){t7.cv(),t6.cv(),nullptr})) goto _0;
			if (!(t7.get())) goto _3;
		}
		{
			Variant t8;
			c.f.fLine=8;
			if (g->GetMember(ctx,Res<Obj>(outResult).cv(),Kdata.cv(),t8.cv())) goto _0;
			Txt t9;
			if (g->Call(ctx,(PCV[]){t9.cv(),Long(10).cv()},1,90)) goto _0;
			Col t10;
			if (g->Call(ctx,(PCV[]){t10.cv(),t8.cv(),t9.cv(),Long(1).cv()},3,1554)) goto _0;
			g->Check(ctx);
			lcol=t10.get();
		}
		{
			Col t11;
			c.f.fLine=9;
			if (g->Call(ctx,(PCV[]){t11.cv()},0,1472)) goto _0;
			g->Check(ctx);
			if (g->SetMember(ctx,Res<Obj>(outResult).cv(),Klist.cv(),t11.cv())) goto _0;
		}
		{
			Obj t12;
			c.f.fLine=10;
			if (g->Call(ctx,(PCV[]){t12.cv(),lcol.cv()},1,1510)) goto _0;
			g->Check(ctx);
			l__4D__auto__iter__0=t12.get();
		}
_4:
		{
			Ref t13;
			t13.setLocalRef(ctx,lline.cv());
			Bool t14;
			if (g->Call(ctx,(PCV[]){t14.cv(),l__4D__auto__iter__0.cv(),t13.cv()},2,1511)) goto _0;
			if (!(t14.get())) goto _5;
		}
		{
			Long t15;
			t15=2+1;
			Col t16;
			c.f.fLine=11;
			if (g->Call(ctx,(PCV[]){t16.cv(),lline.cv(),K_20.cv(),t15.cv()},3,1554)) goto _0;
			g->Check(ctx);
			llineitems=t16.get();
		}
		{
			Obj t17;
			c.f.fLine=12;
			if (g->Call(ctx,(PCV[]){t17.cv()},0,1471)) goto _0;
			g->Check(ctx);
			ldiritem=t17.get();
		}
		{
			Variant t18;
			c.f.fLine=13;
			if (g->GetMember(ctx,llineitems.cv(),Klength.cv(),t18.cv())) goto _0;
			Bool t19;
			if (g->OperationOnAny(ctx,12,t18.cv(),Num(9).cv(),t19.cv())) goto _0;
			if (!(t19.get())) goto _6;
		}
		{
			Variant t20;
			c.f.fLine=14;
			if (g->GetMember(ctx,llineitems.cv(),Long(0).cv(),t20.cv())) goto _0;
			if (g->SetMember(ctx,ldiritem.cv(),Kaccess.cv(),t20.cv())) goto _0;
		}
		{
			Variant t21;
			c.f.fLine=15;
			if (g->GetMember(ctx,llineitems.cv(),Long(1).cv(),t21.cv())) goto _0;
			if (g->SetMember(ctx,ldiritem.cv(),Ktype.cv(),t21.cv())) goto _0;
		}
		{
			Variant t22;
			c.f.fLine=16;
			if (g->GetMember(ctx,llineitems.cv(),Long(2).cv(),t22.cv())) goto _0;
			if (g->SetMember(ctx,ldiritem.cv(),Kowner.cv(),t22.cv())) goto _0;
		}
		{
			Variant t23;
			c.f.fLine=17;
			if (g->GetMember(ctx,llineitems.cv(),Long(3).cv(),t23.cv())) goto _0;
			if (g->SetMember(ctx,ldiritem.cv(),Kgroup.cv(),t23.cv())) goto _0;
		}
		{
			Variant t24;
			c.f.fLine=18;
			if (g->GetMember(ctx,llineitems.cv(),Long(4).cv(),t24.cv())) goto _0;
			if (g->SetMember(ctx,ldiritem.cv(),Ksize.cv(),t24.cv())) goto _0;
		}
		{
			Col t25;
			c.f.fLine=19;
			if (g->Call(ctx,(PCV[]){t25.cv(),KJan.cv(),KFeb.cv(),KMar.cv(),KApr.cv(),KMay.cv(),KJun.cv(),KJul.cv(),KAug.cv(),KSep.cv(),KOct.cv(),KNov.cv(),KDec.cv()},12,1472)) goto _0;
			g->Check(ctx);
			ldatecol=t25.get();
		}
		{
			Variant t26;
			c.f.fLine=20;
			if (g->GetMember(ctx,llineitems.cv(),Long(5).cv(),t26.cv())) goto _0;
			Variant t27;
			if (g->Call(ctx,(PCV[]){t27.cv(),ldatecol.cv(),KindexOf.cv(),t26.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Variant t28;
			if (g->OperationOnAny(ctx,0,t27.cv(),Num(1).cv(),t28.cv())) goto _0;
			Long t29;
			if (!g->GetValue(ctx,(PCV[]){t29.cv(),t28.cv(),nullptr})) goto _0;
			lmonth=t29.get();
		}
		{
			Variant t30;
			c.f.fLine=21;
			if (g->GetMember(ctx,llineitems.cv(),Long(6).cv(),t30.cv())) goto _0;
			Num t31;
			if (g->Call(ctx,(PCV[]){t31.cv(),t30.cv()},1,11)) goto _0;
			lday=(sLONG)lrint(t31.get());
		}
		{
			Variant t33;
			c.f.fLine=22;
			if (g->GetMember(ctx,llineitems.cv(),Long(7).cv(),t33.cv())) goto _0;
			Txt t34;
			if (g->Call(ctx,(PCV[]){t34.cv(),t33.cv(),Long(3).cv(),Long(1).cv()},3,12)) goto _0;
			Bool t35;
			t35=g->CompareString(ctx,t34.get(),K_3A.get())==0;
			if (!(t35.get())) goto _7;
		}
		{
			Date t36;
			c.f.fLine=23;
			if (g->Call(ctx,(PCV[]){t36.cv()},0,33)) goto _0;
			Date t37;
			t37=t36.get();
			Long t38;
			if (g->Call(ctx,(PCV[]){t38.cv(),t37.cv()},1,25)) goto _0;
			lyear=t38.get();
		}
		{
			Variant t39;
			c.f.fLine=24;
			if (g->GetMember(ctx,llineitems.cv(),Long(7).cv(),t39.cv())) goto _0;
			Time t40;
			if (g->Call(ctx,(PCV[]){t40.cv(),t39.cv()},1,179)) goto _0;
			ltime=t40.get();
		}
		goto _8;
_7:
		{
			Variant t41;
			c.f.fLine=26;
			if (g->GetMember(ctx,llineitems.cv(),Long(6).cv(),t41.cv())) goto _0;
			Num t42;
			if (g->Call(ctx,(PCV[]){t42.cv(),t41.cv()},1,11)) goto _0;
			lyear=(sLONG)lrint(t42.get());
		}
		ltime=Time(0).get();
_8:
		{
			Date t44;
			t44=Date(0,0,0).get();
			Date t45;
			c.f.fLine=29;
			if (g->Call(ctx,(PCV[]){t45.cv(),t44.cv(),lyear.cv(),lmonth.cv(),lday.cv()},4,393)) goto _0;
			g->Check(ctx);
			ldate=t45.get();
		}
		{
			Date t46;
			t46=ldate.get();
			c.f.fLine=30;
			if (g->SetMember(ctx,ldiritem.cv(),Kdate.cv(),t46.cv())) goto _0;
		}
		{
			Time t47;
			t47=ltime.get();
			c.f.fLine=31;
			if (g->SetMember(ctx,ldiritem.cv(),Ktime.cv(),t47.cv())) goto _0;
		}
		{
			Variant t48;
			c.f.fLine=32;
			if (g->GetMember(ctx,llineitems.cv(),Long(8).cv(),t48.cv())) goto _0;
			if (g->SetMember(ctx,ldiritem.cv(),Kname.cv(),t48.cv())) goto _0;
		}
		{
			Variant t49;
			c.f.fLine=33;
			if (g->GetMember(ctx,Res<Obj>(outResult).cv(),Klist.cv(),t49.cv())) goto _0;
			if (g->Call(ctx,(PCV[]){nullptr,t49.cv(),Kpush.cv(),ldiritem.cv()},3,1500)) goto _0;
			g->Check(ctx);
		}
		goto _9;
_6:
		{
			Bool t50;
			t50=Bool(0).get();
			c.f.fLine=35;
			if (g->SetMember(ctx,Res<Obj>(outResult).cv(),Ksuccess.cv(),t50.cv())) goto _0;
		}
		c.f.fLine=36;
		if (g->SetMember(ctx,Res<Obj>(outResult).cv(),Kerror.cv(),kiXKWqWzSOCM.cv())) goto _0;
_9:
		goto _4;
_5:
		{
			Obj t51;
			l__4D__auto__iter__0=t51.get();
		}
_3:
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K_2DV;
extern Txt K__runWorker;
extern unsigned char D_proc_FileTransfer_2Eversion[];
void proc_FileTransfer_2Eversion( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2Eversion);
	if (!ctx->doingAbort) try {
		new ( outResult) Obj();
		{
			Obj t0;
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			Variant t1;
			if (g->Call(ctx,(PCV[]){t1.cv(),t0.cv(),K__runWorker.cv(),K_2DV.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Obj t2;
			if (!g->GetValue(ctx,(PCV[]){t2.cv(),t1.cv(),nullptr})) goto _0;
			Res<Obj>(outResult)=t2.get();
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K_2F;
extern Txt K__buildURL;
extern Txt K__runWorker;
extern Txt Kdata;
extern Txt Ksuccess;
extern unsigned char D_proc_FileTransfer_2Evalidate[];
void proc_FileTransfer_2Evalidate( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_2Evalidate);
	if (!ctx->doingAbort) try {
		Variant lurl;
		new ( outResult) Obj();
		{
			Obj t0;
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1470)) goto _0;
			Variant t1;
			if (g->Call(ctx,(PCV[]){t1.cv(),t0.cv(),K__buildURL.cv()},2,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t1.cv(),lurl.cv(),nullptr})) goto _0;
		}
		{
			Variant t2;
			c.f.fLine=2;
			if (!g->GetValue(ctx,(PCV[]){t2.cv(),lurl.cv(),nullptr})) goto _0;
			Variant t3;
			if (g->OperationOnAny(ctx,0,t2.cv(),K_2F.cv(),t3.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t3.cv(),lurl.cv(),nullptr})) goto _0;
		}
		{
			Obj t4;
			c.f.fLine=3;
			if (g->Call(ctx,(PCV[]){t4.cv()},0,1470)) goto _0;
			Variant t5;
			if (g->Call(ctx,(PCV[]){t5.cv(),t4.cv(),K__runWorker.cv(),lurl.cv()},3,1498)) goto _0;
			g->Check(ctx);
			Obj t6;
			if (!g->GetValue(ctx,(PCV[]){t6.cv(),t5.cv(),nullptr})) goto _0;
			Res<Obj>(outResult)=t6.get();
		}
		{
			Variant t7;
			c.f.fLine=4;
			if (g->GetMember(ctx,Res<Obj>(outResult).cv(),Ksuccess.cv(),t7.cv())) goto _0;
			Bool t8;
			if (g->OperationOnAny(ctx,6,t7.cv(),Bool(1).cv(),t8.cv())) goto _0;
			if (!(t8.get())) goto _2;
		}
		c.f.fLine=5;
		if (g->SetMember(ctx,Res<Obj>(outResult).cv(),Kdata.cv(),Value_null().cv())) goto _0;
_2:
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
extern Txt K;
extern Txt K__host;
extern Txt K__password;
extern Txt K__protocoll;
extern Txt K__user;
extern Txt Kftp;
extern Txt Kftps;
extern Txt KindexOf;
extern Txt KonData;
extern Txt Ktext;
extern Txt kMf7H6EyrHtc;
extern Txt kxoLTHUfnMHM;
extern unsigned char D_proc_FileTransfer_3Aconstructor[];
void proc_FileTransfer_3Aconstructor( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_FileTransfer_3Aconstructor);
	if (!ctx->doingAbort) try {
		Col lcol;
		{
			Bool t0;
			t0=ctx->withAssert;
			if (!(t0.get())) goto _2;
		}
		{
			Bool t1;
			t1=g->CompareString(ctx,Parm<Txt>(inParams,inNbParam,1).get(),K.get())!=0;
			Bool t2;
			t2=t1.get();
			c.f.fLine=1;
			if (g->Call(ctx,(PCV[]){nullptr,t2.cv(),kxoLTHUfnMHM.cv()},2,1129)) goto _0;
			g->Check(ctx);
		}
_2:
		{
			Col t3;
			c.f.fLine=2;
			if (g->Call(ctx,(PCV[]){t3.cv(),Kftp.cv(),Kftps.cv()},2,1472)) goto _0;
			g->Check(ctx);
			lcol=t3.get();
		}
		{
			Bool t4;
			t4=ctx->withAssert;
			if (!(t4.get())) goto _3;
		}
		{
			Variant t5;
			c.f.fLine=3;
			if (g->Call(ctx,(PCV[]){t5.cv(),lcol.cv(),KindexOf.cv(),Parm<Txt>(inParams,inNbParam,4).cv()},3,1498)) goto _0;
			g->Check(ctx);
			Bool t6;
			if (g->OperationOnAny(ctx,12,t5.cv(),Num(0).cv(),t6.cv())) goto _0;
			Bool t7;
			t7=t6.get();
			if (g->Call(ctx,(PCV[]){nullptr,t7.cv(),kMf7H6EyrHtc.cv()},2,1129)) goto _0;
		}
_3:
		{
			Obj t8;
			c.f.fLine=4;
			if (g->Call(ctx,(PCV[]){t8.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t8.cv(),K__host.cv(),Parm<Txt>(inParams,inNbParam,1).cv())) goto _0;
		}
		{
			Obj t9;
			c.f.fLine=5;
			if (g->Call(ctx,(PCV[]){t9.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t9.cv(),K__user.cv(),Parm<Txt>(inParams,inNbParam,2).cv())) goto _0;
		}
		{
			Obj t10;
			c.f.fLine=6;
			if (g->Call(ctx,(PCV[]){t10.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t10.cv(),K__password.cv(),Parm<Txt>(inParams,inNbParam,3).cv())) goto _0;
		}
		{
			Obj t11;
			c.f.fLine=7;
			if (g->Call(ctx,(PCV[]){t11.cv()},0,1470)) goto _0;
			if (g->SetMember(ctx,t11.cv(),K__protocoll.cv(),Parm<Txt>(inParams,inNbParam,4).cv())) goto _0;
		}
		{
			Obj t12;
			c.f.fLine=8;
			if (g->Call(ctx,(PCV[]){t12.cv()},0,1470)) goto _0;
			Obj t13;
			if (g->Call(ctx,(PCV[]){t13.cv(),Ktext.cv(),K.cv()},2,1471)) goto _0;
			g->Check(ctx);
			if (g->SetMember(ctx,t12.cv(),KonData.cv(),t13.cv())) goto _0;
		}
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
