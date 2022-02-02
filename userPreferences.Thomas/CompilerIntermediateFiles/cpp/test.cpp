extern Txt KFileTransfer;
extern Txt KGJwdvJmSv8;
extern Txt K_2F;
extern Txt K_2Ffolder_2F;
extern Txt K_2Ftest2_2Etxt;
extern Txt K_2Ftest3_2Etxt;
extern Txt K_2Ftest_5B1_2D3_5D_2Etxt;
extern Txt K_3A;
extern Txt KcreateDirectory;
extern Txt Kdata;
extern Txt Kdownload;
extern Txt Kerror;
extern Txt Kftp;
extern Txt Klist;
extern Txt Kneu;
extern Txt Knew;
extern Txt Knewtest2_2Etxt;
extern Txt Ksuccess;
extern Txt Ktechsupport;
extern Txt Ktest2_2Etxt;
extern Txt Kupload;
extern Txt Kvalidate;
extern Txt Kversion;
extern Txt kJ7jw8Z7KIsQ;
extern Txt kLe_AsEevyXE;
extern Txt kTj96mJZngbo;
extern Txt kWZCFsMQMnjQ;
extern Txt khrET0RnbLck;
extern Txt kiEUQXwEz1uY;
extern unsigned char D_proc_TEST[];
void proc_TEST( Asm4d_globals *glob, tProcessGlobals *ctx, int32_t inNbExplicitParam, int32_t inNbParam, PCV inParams[], CV *outResult)
{
	CallChain c(ctx,D_proc_TEST);
	if (!ctx->doingAbort) try {
		Variant llist;
		Txt lsource;
		Variant lresult;
		Obj lftp;
		Txt ltarget;
		Variant lerror;
		Variant lanswer;
		{
			Obj t0;
			c.f.fLine=3;
			if (g->Call(ctx,(PCV[]){t0.cv()},0,1710)) goto _0;
			Variant t1;
			if (g->GetMember(ctx,t0.cv(),KFileTransfer.cv(),t1.cv())) goto _0;
			Variant t2;
			if (g->Call(ctx,(PCV[]){t2.cv(),t1.cv(),Knew.cv(),kLe_AsEevyXE.cv(),Ktechsupport.cv(),KGJwdvJmSv8.cv(),Kftp.cv()},6,1498)) goto _0;
			g->Check(ctx);
			Obj t3;
			if (!g->GetValue(ctx,(PCV[]){t3.cv(),t2.cv(),nullptr})) goto _0;
			lftp=t3.get();
		}
		c.f.fLine=4;
		if (g->Call(ctx,(PCV[]){nullptr,lftp.cv(),kWZCFsMQMnjQ.cv(),Long(5).cv()},3,1500)) goto _0;
		g->Check(ctx);
		if (!(Bool(0).get())) goto _2;
		{
			Variant t4;
			c.f.fLine=7;
			if (g->Call(ctx,(PCV[]){t4.cv(),lftp.cv(),Kversion.cv()},2,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t4.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t5;
			c.f.fLine=8;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t5.cv())) goto _0;
			Bool t6;
			if (!g->GetValue(ctx,(PCV[]){t6.cv(),t5.cv(),nullptr})) goto _0;
			if (!(t6.get())) goto _3;
		}
		{
			Variant t7;
			c.f.fLine=9;
			if (g->GetMember(ctx,lresult.cv(),Kdata.cv(),t7.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t7.cv(),lanswer.cv(),nullptr})) goto _0;
		}
_3:
_2:
		if (!(Bool(0).get())) goto _4;
		{
			Variant t8;
			c.f.fLine=14;
			if (g->Call(ctx,(PCV[]){t8.cv(),lftp.cv(),Kvalidate.cv()},2,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t8.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t9;
			c.f.fLine=15;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t9.cv())) goto _0;
			Bool t10;
			if (!g->GetValue(ctx,(PCV[]){t10.cv(),t9.cv(),nullptr})) goto _0;
			if (!(t10.get())) goto _5;
		}
		{
			Variant t11;
			c.f.fLine=16;
			if (g->GetMember(ctx,lresult.cv(),Kdata.cv(),t11.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t11.cv(),lanswer.cv(),nullptr})) goto _0;
		}
		goto _6;
_5:
		{
			Variant t12;
			c.f.fLine=18;
			if (g->GetMember(ctx,lresult.cv(),Kerror.cv(),t12.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t12.cv(),lerror.cv(),nullptr})) goto _0;
		}
_6:
_4:
		if (!(Bool(0).get())) goto _7;
		{
			Txt t13;
			c.f.fLine=23;
			if (g->Call(ctx,(PCV[]){t13.cv(),Long(15).cv()},1,487)) goto _0;
			g->Check(ctx);
			g->AddString(t13.get(),Ktest2_2Etxt.get(),lsource.get());
		}
		{
			Txt t15;
			c.f.fLine=24;
			if (g->Call(ctx,(PCV[]){t15.cv(),lsource.cv()},1,1106)) goto _0;
			g->Check(ctx);
			lsource=t15.get();
		}
		{
			Bool t16;
			t16=Bool(1).get();
			Variant t17;
			c.f.fLine=25;
			if (g->Call(ctx,(PCV[]){t17.cv(),lftp.cv(),Kupload.cv(),lsource.cv(),K_2Ftest3_2Etxt.cv(),t16.cv()},5,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t17.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t18;
			c.f.fLine=26;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t18.cv())) goto _0;
			Bool t19;
			if (!g->GetValue(ctx,(PCV[]){t19.cv(),t18.cv(),nullptr})) goto _0;
			if (!(t19.get())) goto _8;
		}
		{
			Variant t20;
			c.f.fLine=27;
			if (g->GetMember(ctx,lresult.cv(),Kdata.cv(),t20.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t20.cv(),lanswer.cv(),nullptr})) goto _0;
		}
_8:
_7:
		if (!(Bool(0).get())) goto _9;
		{
			Txt t21;
			c.f.fLine=31;
			if (g->Call(ctx,(PCV[]){t21.cv(),Long(15).cv()},1,487)) goto _0;
			g->Check(ctx);
			g->AddString(t21.get(),Ktest2_2Etxt.get(),lsource.get());
		}
		{
			Txt t23;
			c.f.fLine=32;
			if (g->Call(ctx,(PCV[]){t23.cv(),lsource.cv()},1,1106)) goto _0;
			g->Check(ctx);
			lsource=t23.get();
		}
		{
			Bool t24;
			t24=Bool(1).get();
			c.f.fLine=33;
			if (g->Call(ctx,(PCV[]){nullptr,lftp.cv(),kTj96mJZngbo.cv(),t24.cv()},3,1500)) goto _0;
			g->Check(ctx);
		}
		{
			Bool t25;
			t25=Bool(1).get();
			c.f.fLine=34;
			if (g->Call(ctx,(PCV[]){nullptr,lftp.cv(),kJ7jw8Z7KIsQ.cv(),t25.cv()},3,1500)) goto _0;
			g->Check(ctx);
		}
		{
			Bool t26;
			t26=Bool(1).get();
			Variant t27;
			c.f.fLine=35;
			if (g->Call(ctx,(PCV[]){t27.cv(),lftp.cv(),Kupload.cv(),lsource.cv(),khrET0RnbLck.cv(),t26.cv()},5,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t27.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t28;
			c.f.fLine=36;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t28.cv())) goto _0;
			Bool t29;
			if (!g->GetValue(ctx,(PCV[]){t29.cv(),t28.cv(),nullptr})) goto _0;
			if (!(t29.get())) goto _10;
		}
		{
			Variant t30;
			c.f.fLine=37;
			if (g->GetMember(ctx,lresult.cv(),Kdata.cv(),t30.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t30.cv(),lanswer.cv(),nullptr})) goto _0;
		}
_10:
_9:
		if (!(Bool(0).get())) goto _11;
		{
			Variant t31;
			c.f.fLine=42;
			if (g->Call(ctx,(PCV[]){t31.cv(),lftp.cv(),kiEUQXwEz1uY.cv(),K_2F.cv()},3,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t31.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t32;
			c.f.fLine=43;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t32.cv())) goto _0;
			Bool t33;
			if (!g->GetValue(ctx,(PCV[]){t33.cv(),t32.cv(),nullptr})) goto _0;
			if (!(t33.get())) goto _12;
		}
		{
			Variant t34;
			c.f.fLine=44;
			if (g->GetMember(ctx,lresult.cv(),Klist.cv(),t34.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t34.cv(),llist.cv(),nullptr})) goto _0;
		}
_12:
_11:
		if (!(Bool(0).get())) goto _13;
		lsource=K_2Ftest2_2Etxt.get();
		{
			Txt t35;
			c.f.fLine=50;
			if (g->Call(ctx,(PCV[]){t35.cv(),Long(15).cv()},1,487)) goto _0;
			g->Check(ctx);
			g->AddString(t35.get(),Knewtest2_2Etxt.get(),ltarget.get());
		}
		{
			Txt t37;
			c.f.fLine=51;
			if (g->Call(ctx,(PCV[]){t37.cv(),ltarget.cv()},1,1106)) goto _0;
			g->Check(ctx);
			ltarget=t37.get();
		}
		{
			Variant t38;
			c.f.fLine=52;
			if (g->Call(ctx,(PCV[]){t38.cv(),lftp.cv(),Kdownload.cv(),lsource.cv(),ltarget.cv()},4,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t38.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t39;
			c.f.fLine=53;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t39.cv())) goto _0;
			Bool t40;
			if (!g->GetValue(ctx,(PCV[]){t40.cv(),t39.cv(),nullptr})) goto _0;
			if (!(t40.get())) goto _14;
		}
		{
			Variant t41;
			c.f.fLine=54;
			if (g->GetMember(ctx,lresult.cv(),Kdata.cv(),t41.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t41.cv(),lanswer.cv(),nullptr})) goto _0;
		}
_14:
_13:
		if (!(Bool(0).get())) goto _15;
		lsource=K_2Ftest_5B1_2D3_5D_2Etxt.get();
		{
			Txt t42;
			c.f.fLine=60;
			if (g->Call(ctx,(PCV[]){t42.cv(),Long(15).cv()},1,487)) goto _0;
			g->Check(ctx);
			Txt t43;
			g->AddString(t42.get(),Kneu.get(),t43.get());
			g->AddString(t43.get(),K_3A.get(),ltarget.get());
		}
		{
			Txt t45;
			c.f.fLine=61;
			if (g->Call(ctx,(PCV[]){t45.cv(),ltarget.cv()},1,1106)) goto _0;
			g->Check(ctx);
			ltarget=t45.get();
		}
		{
			Variant t46;
			c.f.fLine=62;
			if (g->Call(ctx,(PCV[]){t46.cv(),lftp.cv(),Kdownload.cv(),lsource.cv(),ltarget.cv()},4,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t46.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t47;
			c.f.fLine=63;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t47.cv())) goto _0;
			Bool t48;
			if (!g->GetValue(ctx,(PCV[]){t48.cv(),t47.cv(),nullptr})) goto _0;
			if (!(t48.get())) goto _16;
		}
		{
			Variant t49;
			c.f.fLine=64;
			if (g->GetMember(ctx,lresult.cv(),Kdata.cv(),t49.cv())) goto _0;
			if (!g->SetValue(ctx,(PCV[]){t49.cv(),lanswer.cv(),nullptr})) goto _0;
		}
_16:
_15:
		if (!(Bool(1).get())) goto _17;
		{
			Variant t50;
			c.f.fLine=69;
			if (g->Call(ctx,(PCV[]){t50.cv(),lftp.cv(),KcreateDirectory.cv(),K_2Ffolder_2F.cv()},3,1498)) goto _0;
			g->Check(ctx);
			if (!g->SetValue(ctx,(PCV[]){t50.cv(),lresult.cv(),nullptr})) goto _0;
		}
		{
			Variant t51;
			c.f.fLine=70;
			if (g->GetMember(ctx,lresult.cv(),Ksuccess.cv(),t51.cv())) goto _0;
			Bool t52;
			if (!g->GetValue(ctx,(PCV[]){t52.cv(),t51.cv(),nullptr})) goto _0;
			if (!(t52.get())) goto _18;
		}
_18:
_17:
_0:
_1:
;
	} catch( Asm4d_error e) { g->Error( ctx, e); }

}
