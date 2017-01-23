--Generate Effect
function c419.initial_effect(c)
	--edit to xyz procedure to add filters and checks
	function aux.AddXyzProcedure(c,f,lv,ct,alterf,desc,maxct,op)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		mt.xyz_filter=function(mc) return mc and (not f or f(mc)) and mc:IsXyzLevel(c,lv) and not mc:IsType(TYPE_TOKEN) end
		mt.minxyzct=ct
		if not maxct then
			mt.maxxyzct=ct
		else
			if maxct==5 and code~=14306092 and code~=63504681 and code~=23776077 then
				maxct=63
				mt.maxxyzct=63
			else
				mt.maxxyzct=maxct
			end
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		if not maxct then maxct=ct end
		if alterf then
			e1:SetCondition(Auxiliary.XyzCondition2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetTarget(Auxiliary.XyzTarget2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetOperation(Auxiliary.XyzOperation2(f,lv,ct,maxct,alterf,desc,op))
		else
			e1:SetCondition(Auxiliary.XyzCondition(f,lv,ct,maxct))
			e1:SetTarget(Auxiliary.XyzTarget(f,lv,ct,maxct))
			e1:SetOperation(Auxiliary.XyzOperation(f,lv,ct,maxct))
		end
		e1:SetValue(SUMMON_TYPE_XYZ)
		c:RegisterEffect(e1)
	end

	if not c419.global_check then
		c419.global_check=true
		--register for graveyard synchro
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetOperation(c419.op1)
		Duel.RegisterEffect(e1,0)
		--register for xyz
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetOperation(c419.op2)
		Duel.RegisterEffect(e2,0)
		--register for xyz synchro
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_ADJUST)
		e3:SetOperation(c419.op3)
		Duel.RegisterEffect(e3,0)
		--register for ocg cardians
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_ADJUST)
		e3:SetOperation(c419.op4)
		Duel.RegisterEffect(e3,0)
		--register for atk change
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e5:SetCode(EVENT_ADJUST)
		e5:SetOperation(c419.op5)
		Duel.RegisterEffect(e5,0)
		local atkeff=Effect.CreateEffect(c)
		atkeff:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		atkeff:SetCode(EVENT_CHAIN_SOLVED)
		atkeff:SetOperation(c419.atkraiseeff)
		Duel.RegisterEffect(atkeff,0)
		local atkadj=Effect.CreateEffect(c)
		atkadj:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		atkadj:SetCode(EVENT_ADJUST)
		atkadj:SetOperation(c419.atkraiseadj)
		Duel.RegisterEffect(atkadj,0)
	end
end
function c419.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsType,0,LOCATION_GRAVE,LOCATION_GRAVE,nil,TYPE_SYNCHRO)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(2081)==0 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,2))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetRange(LOCATION_GRAVE)
			e1:SetValue(SUMMON_TYPE_SYNCHRO)
			e1:SetCondition(c419.syncon)
			e1:SetOperation(c419.synop)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(2081,nil,0,1) 	
		end
		tc=g:GetNext()
	end
end
function c419.syncon(e,c,smat,mg)
	if c==nil then return true end
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local tuner=Duel.GetMatchingGroup(c419.gvmatfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nontuner=Duel.GetMatchingGroup(c419.gvmatfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	if not mt.sync then return false end
	return tuner:IsExists(c419.gvlvfilter,1,nil,c,nontuner)
end
function c419.gvlvfilter(c,syncard,nontuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=c:GetSynchroLevel(syncard)
	local slv=syncard:GetLevel()
	local nt=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and slv-lv>0 and nt:CheckWithSumEqual(Card.GetSynchroLevel,slv-lv,mt.minntct,mt.maxntct,syncard)
end
function c419.gvlvfilter2(c,syncard,tuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=c:GetSynchroLevel(syncard)
	local slv=syncard:GetLevel()
	local nt=tuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and lv+slv>0 and nt:CheckWithSumEqual(Card.GetSynchroLevel,lv+slv,mt.minntct,mt.maxntct,syncard)
end
function c419.gvmatfilter1(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_TUNER) and c:IsHasEffect(511002081) and c:IsCanBeSynchroMaterial(syncard) 
		and mt.tuner_filter and mt.tuner_filter(c)
end
function c419.gvmatfilter2(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard) 
		and mt.nontuner_filter and mt.nontuner_filter(c)
end
function c419.synop(e,tp,eg,ep,ev,re,r,rp,c,smat,mg)
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local tuner=Duel.GetMatchingGroup(c419.gvmatfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local nontuner=Duel.GetMatchingGroup(c419.gvmatfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
	local mat1
	if c:IsSetCard(0x301) then
		nontuner=nontuner:Filter(c419.gvlvfilter2,nil,c,tuner)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		mat1=nontuner:Select(tp,1,1,nil)
		local tlv=mat1:GetFirst():GetSynchroLevel(c)
		tuner=tuner:Filter(Card.IsCanBeSynchroMaterial,nil,c,mat1:GetFirst())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat2=tuner:SelectWithSumEqual(tp,Card.GetSynchroLevel,c:GetLevel()+tlv,mt.minntct,mt.maxntct,c)
		mat1:Merge(mat2)
	elseif mt.dobtun then
		mat1=Group.CreateGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local t1=tuner:FilterSelect(tp,c419.dtfilter1,1,1,nil,c,c:GetLevel(),tuner,nontuner)
		tuner1=t1:GetFirst()
		mat1:AddCard(tuner1)
		local lv1=tuner1:GetSynchroLevel(c)
		local f1=tuner1.tuner_filter
		local t2=nil
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		t2=tuner:FilterSelect(tp,c419.dtfilter2,1,1,tuner1,c,c:GetLevel()-lv1,nontuner,f1,tuner1)
		local tuner2=t2:GetFirst()
		mat1:AddCard(tuner2)
		local lv2=tuner2:GetSynchroLevel(c)
		local f2=tuner2.tuner_filter
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m3=nontuner:FilterSelect(tp,c419.dtfilter3,1,1,nil,c,c:GetLevel()-lv1-lv2,f1,f2)
		mat1:Merge(m3)
	else
		tuner=tuner:Filter(c419.gvlvfilter,nil,c,nontuner)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		mat1=tuner:Select(tp,1,1,nil)
		local tlv=mat1:GetFirst():GetSynchroLevel(c)
		nontuner=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,c,mat1:GetFirst())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat2=nontuner:SelectWithSumEqual(tp,Card.GetSynchroLevel,c:GetLevel()-tlv,mt.minntct,mt.maxntct,c)
		mat1:Merge(mat2)
	end
	c:SetMaterial(mat1)
	Duel.SendtoGrave(mat1,REASON_MATERIAL+REASON_SYNCHRO)
end
function c419.filterxyz(c)
	local code=c:GetOriginalCode()
	return c:IsType(TYPE_XYZ) and c:GetFlagEffect(419)==0 
		and ((c.minxyzct and c.minxyzct>0) or code==65305468 or code==52653092 or code==57314798 or code==23187256)
end
function c419.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c419.filterxyz,c:GetControler(),LOCATION_EXTRA,LOCATION_EXTRA,nil)
	if g:GetCount()<=0 then return end
	local xg=Group.CreateGroup()
	for i=1,15 do
		local tck=Duel.CreateToken(tp,419)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(i)
		tck:RegisterEffect(e1)
		xg:AddCard(tck)
	end
	xg:KeepAlive()
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetOriginalCode()
		if code==65305468 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,0))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_XYZ)
			e1:SetCondition(c419.xyzcon65305468)
			e1:SetOperation(c419.xyzop65305468)
			tc:RegisterEffect(e1)
		elseif code==57314798 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,0))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_XYZ)
			e1:SetCondition(c419.xyzcon57314798)
			e1:SetOperation(c419.xyzop57314798)
			tc:RegisterEffect(e1)
		elseif code==52653092 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,0))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_XYZ)
			e1:SetCondition(c419.xyzcon52653092)
			e1:SetOperation(c419.xyzop52653092)
			tc:RegisterEffect(e1)
		elseif code==23187256 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,0))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_XYZ)
			e1:SetCondition(c419.xyzcon23187256)
			e1:SetOperation(c419.xyzop23187256)
			tc:RegisterEffect(e1)
		else
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,0))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_XYZ)
			e1:SetCondition(c419.xyzcon)
			e1:SetOperation(c419.xyzop)
			e1:SetLabelObject(xg)
			tc:RegisterEffect(e1)
		end
		tc:RegisterFlagEffect(419,nil,0,1)
		tc=g:GetNext()
	end
end
function c419.mfilter(c,xyz)
	return c:IsFaceup() and xyz.xyz_filter(c) and c:IsCanBeXyzMaterial(xyz)
end
function c419.amfilter(c)
	return c:GetEquipGroup():IsExists(Card.IsHasEffect,1,nil,511001175)
end
function c419.doubfilter(c,xyz)
	return c:IsHasEffect(511001225) and (not c.xyzlimit2 or c.xyzlimit2(xyz))
end
function c419.subfilter(c,rk,xyz,xg)
	if c:IsLocation(LOCATION_GRAVE) then
		return c:IsHasEffect(511002793) and xyz.xyz_filter(c) and c:IsCanBeXyzMaterial(xyz)
	else
		return (c:GetFlagEffect(511000189)==rk	and xg:IsExists(c419.subfilterchk,1,nil,xyz)) or c:IsHasEffect(511002116)
	end
end
function c419.subfilterchk(c,xyz)
	c:AssumeProperty(ASSUME_TYPE,TYPE_MONSTER)
	return xyz.xyz_filter(c)
end
function c419.m12(c,rk,xyz,xg)
	return c419.mfilter(c,xyz) or c419.subfilter(c,rk,xyz,xg)
end
function c419.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
	local tp=c:GetControler()
	local rk=c:GetRank()
	local minct=c.minxyzct
	local maxct=c.maxxyzct
	local xg=e:GetLabelObject()
	local mg
	if og then
		mg=og:Filter(c419.m12,nil,rk,c,xg)
	else
		mg=Duel.GetMatchingGroup(c419.mfilter,tp,LOCATION_MZONE,0,nil,c)
		local mg2=Duel.GetMatchingGroup(c419.subfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,rk,c,xg)
		mg:Merge(mg2)
	end
	if not (not min or min<=minct and max>=maxct) then return false end
	if not mg:IsExists(c419.amfilter,1,nil) and not mg:IsExists(c419.doubfilter,1,nil,c)
		and not mg:IsExists(c419.subfilter,1,nil,rk,c,xg) 
		and not mg:IsExists(Card.IsHasEffect,1,nil,511002116) then return false end
	local g=mg:Filter(c419.amfilter,nil)
	local eqg=Group.CreateGroup()
	local tce=g:GetFirst()
	while tce do
		local eq=tce:GetEquipGroup()
		eq=eq:Filter(Card.IsHasEffect,nil,511001175)
		g:Merge(eq)
		tce=g:GetNext()
	end
	local dob=mg:Filter(c419.doubfilter,nil,c)
	local dobc=dob:GetFirst()
	while dobc do
		minct=minct-1
		maxct=maxct-1
		dobc=dob:GetNext()
	end
	mg:Merge(g)
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or mg:IsExists(Card.IsLocation,1,nil,LOCATION_MZONE)) and mg:GetCount()>=minct
end
function c419.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local g1=Group.CreateGroup()
	g1:KeepAlive()
	local c=e:GetHandler()
	if og and not min then
		g1=og
		local sg=Group.CreateGroup()
		local tc=g1:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg:Merge(sg1)
			tc=g1:GetNext()
		end
		sg:Merge(eqg)
		Duel.SendtoGrave(sg,REASON_RULE)
	else
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local rk=c:GetRank()
		local minct=c.minxyzct
		local maxct=c.maxxyzct
		if min then
			if min>minct then minct=min end
			if max<maxct then maxct=max end
		end
		local xg=e:GetLabelObject()
		local mg
		if og then
			mg=og:Filter(c419.m12,nil,rk,c,xg)
		else
			mg=Duel.GetMatchingGroup(c419.mfilter,tp,LOCATION_MZONE,0,nil,c)
			local mg2=Duel.GetMatchingGroup(c419.subfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,rk,c,xg)
			mg:Merge(mg2)
		end
		local eqg=Group.CreateGroup()
		eqg:KeepAlive()
		repeat
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local gc
			if ft<=0 then
				gc=mg:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
				ft=ft+1
			else
				gc=mg:Select(tp,1,1,nil):GetFirst()
			end
			if gc and c419.amfilter(gc) then
				eq=gc:GetEquipGroup()
				eq=eq:Filter(Card.IsHasEffect,nil,511001175)
				mg:Merge(eq)
			elseif gc and gc:GetEquipTarget()~=nil then
				eqg:AddCard(gc)
			end
			if gc and c419.doubfilter(gc,c) and maxct>0 and (mg:GetCount()<=maxct or Duel.SelectYesNo(tp,aux.Stringid(61965407,0))) then
				minct=minct-1
				maxct=maxct-1
			end
			if gc and gc:IsHasEffect(511002116) then
				gc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			end
			if gc and gc:IsHasEffect(511002793) then
				gc:RegisterFlagEffect(511002794,nil,0,0)
			end
			mg:RemoveCard(gc)
			g1:AddCard(gc)
			minct=minct-1
			maxct=maxct-1
		until mg:GetCount()<=0 or (minct<=0 and (maxct<=0 or not Duel.SelectYesNo(tp,aux.Stringid(17874674,0))))
		g1:Remove(Card.IsHasEffect,nil,511002116)
		g1:Remove(Card.IsHasEffect,nil,511002115)
		local sg=Group.CreateGroup()
		local tc=g1:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg:Merge(sg1)
			tc=g1:GetNext()
		end
		sg:Merge(eqg)
		Duel.SendtoGrave(sg,REASON_RULE)
	end
	c:SetMaterial(g1)
	Duel.Overlay(c,g1)
end
function c419.mfilter65305468(c,xyzc)
	if c:IsLocation(LOCATION_GRAVE) and not c:IsHasEffect(511002793) then return false end
	if c:IsOnField() and c:IsFacedown() then return false end
	return (c:IsType(TYPE_XYZ) and not c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc)) 
		or c:IsHasEffect(511002116)
end
function c419.xyzfilter165305468(c,tp,g,xyz)
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or c:IsLocation(LOCATION_MZONE))
		and (g:IsExists(Card.IsHasEffect,1,c,511002116) or g:IsExists(c419.xyzfilter265305468,1,c,c:GetRank(),c:IsHasEffect(511002116),c:IsHasEffect(511002793))
			or c419.doubfilter(c,xyz) or c419.amfilter(c))
end
function c419.xyzfilter265305468(c,rk,free,effchk)
	return free or (c:GetRank()==rk and (effchk or c:IsHasEffect(511002793))) or c:IsHasEffect(511002116)
end
function c419.xyzcon65305468(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	if og then
		mg=og:Filter(c419.mfilter65305468,nil,c)
	else
		mg=Duel.GetMatchingGroup(c419.mfilter65305468,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
	end
	return (not min or min<=2 and max>=2) and mg:IsExists(c419.xyzfilter165305468,1,nil,tp,mg,c)
end
function c419.xyzop65305468(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	local sg=Group.CreateGroup()
	if og and not min then
		g=og
		local tc=og:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=og:GetNext()
		end
	else
		local mg=nil
		if og then
			mg=og:Filter(c419.mfilter65305468,nil,c)
		else
			mg=Duel.GetMatchingGroup(c419.mfilter65305468,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,c419.xyzfilter165305468,1,1,nil,tp,mg,c)
		local tc1=g:GetFirst()
		local free=false
		if tc1:IsHasEffect(511002116) then
			tc1:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			free=true
		end
		local eqg=tc1:GetEquipGroup()
		local eqc=eqg:GetFirst()
		while eqc do
			if eqc:IsHasEffect(511001175) then
				mg:AddCard(eqc)
			end
			eqc=eqg:GetNext()
		end
		if not tc1:IsHasEffect(511001225) or (mg:IsExists(c419.xyzfilter265305468,1,tc1,tc1:GetRank(),free,tc1:IsHasEffect(511002793)) 
			and Duel.SelectYesNo(tp,560)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g2=mg:FilterSelect(tp,c419.xyzfilter265305468,1,1,tc1,tc1:GetRank(),free,tc1:IsHasEffect(511002793))
			local tc2=g2:GetFirst()
			if tc2:IsHasEffect(511002116) then
				tc2:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			end
			g:Merge(g2)
			sg:Merge(tc1:GetOverlayGroup())
			sg:Merge(tc2:GetOverlayGroup())
		end
	end
	g:Remove(Card.IsHasEffect,nil,511002116)
	g:Remove(Card.IsHasEffect,nil,511002115)
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c419.mfilter57314798(c,xyzc)
	if c:IsLocation(LOCATION_GRAVE) and not c:IsHasEffect(511002793) then return false end
	if c:IsOnField() and c:IsFacedown() then return false end
	return (c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc))
		or c:IsHasEffect(511002116)
end
function c419.xyzfilter157314798(c,tp,g,xyz)
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or c:IsLocation(LOCATION_MZONE)) 
		and (g:IsExists(Card.IsHasEffect,1,c,511002116) or g:IsExists(c419.xyzfilter257314798,1,c,c:GetRank(),c:GetCode(),c:IsHasEffect(511002116),c:IsHasEffect(511002793)) 
		or c419.doubfilter(c,xyz) or c419.amfilter(c))
end
function c419.xyzfilter257314798(c,rk,code,free,effchk)
	return free or (c:GetRank()==rk and c:IsCode(code) and (effchk or c:IsHasEffect(511002793))) or c:IsHasEffect(511002116)
end
function c419.xyzcon57314798(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	if og then
		mg=og:Filter(c419.mfilter57314798,nil,c)
	else
		mg=Duel.GetMatchingGroup(c419.mfilter57314798,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
	end
	return (not min or min<=2 and max>=2) and mg:IsExists(c419.xyzfilter157314798,1,nil,tp,mg,c)
end
function c419.xyzop57314798(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	local sg=Group.CreateGroup()
	if og and not min then
		g=og
		local tc=og:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=og:GetNext()
		end
	else
		local mg=nil
		if og then
			mg=og:Filter(c419.mfilter57314798,nil,c)
		else
			mg=Duel.GetMatchingGroup(c419.mfilter57314798,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,c419.xyzfilter157314798,1,1,nil,tp,mg,c)
		local tc1=g:GetFirst()
		local free=false
		if tc1:IsHasEffect(511002116) then
			tc1:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			free=true
		end
		local eqg=tc1:GetEquipGroup()
		local eqc=eqg:GetFirst()
		while eqc do
			if eqc:IsHasEffect(511001175) then
				mg:AddCard(eqc)
			end
			eqc=eqg:GetNext()
		end
		if not tc1:IsHasEffect(511001225) or (mg:IsExists(c419.xyzfilter257314798,1,tc1,tc1:GetRank(),tc1:GetCode(),free,tc1:IsHasEffect(511002793)) 
			and Duel.SelectYesNo(tp,560)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g2=mg:FilterSelect(tp,c419.xyzfilter257314798,1,1,tc1,tc1:GetRank(),tc1:GetCode(),free,tc1:IsHasEffect(511002793))
			local tc2=g2:GetFirst()
			if tc2:IsHasEffect(511002116) then
				tc2:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			end
			g:Merge(g2)
			sg:Merge(tc1:GetOverlayGroup())
			sg:Merge(tc2:GetOverlayGroup())
		end
	end
	g:Remove(Card.IsHasEffect,nil,511002116)
	g:Remove(Card.IsHasEffect,nil,511002115)
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c419.mfilter52653092(c,xyzc)
	if c:IsLocation(LOCATION_GRAVE) and not c:IsHasEffect(511002793) then return false end
	if c:IsOnField() and c:IsFacedown() then return false end
	return (c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc))
		or c:IsHasEffect(511002116)
end
function c419.xyzfilter52653092(c,tp,g,xyz,ct,fchk,spc)
	local fchk2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or c:IsLocation(LOCATION_MZONE) or fchk
	local mg
	local spchk=spc
	local ctc=ct-1
	if c:IsType(TYPE_XYZ) then
		mg=g:Filter(c419.xyzfilterchk52653092,c,c:GetRank())
		if c419.doubfilter(c,xyz) then ctc=ctc-1 spchk=true end
		local eqg=c:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
		if eqg:GetCount()>0 then spchk=true end
		mg:Merge(eqg)
		if c:IsHasEffect(511002116) then spchk=true end
	else
		mg=g:Clone()
		mg:RemoveCard(c)
		spchk=true
	end
	if ctc<=0 then return fchk2 and spchk end
	return mg:IsExists(c419.xyzfilter52653092,1,c,tp,mg,xyz,ctc,fchk2,spchk)
end
function c419.xyzfilterchk52653092(c,rk)
	return c:GetRank()==rk or c:IsHasEffect(511002116) or c:IsHasEffect(511001175)
end
function c419.xyzcon52653092(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	if min and (min>3 or max<3) then return false end
	local mg=nil
	if og then
		mg=og:Filter(c419.mfilter52653092,nil,c)
	else
		mg=Duel.GetMatchingGroup(c419.mfilter52653092,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
	end
	return mg:IsExists(c419.xyzfilter52653092,1,nil,tp,mg,c,3,false,false)
end
function c419.xyzop52653092(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	if og and not min then
		local sg=Group.CreateGroup()
		local tc=og:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=og:GetNext()
		end
		Duel.SendtoGrave(sg,REASON_RULE)
		c:SetMaterial(og)
		Duel.Overlay(c,og)
		return
	end
	local mg=nil
	if og then
		mg=og:Filter(c419.mfilter52653092,nil,c)
	else
		mg=Duel.GetMatchingGroup(c419.mfilter52653092,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
	end
	local xyzchkc
	local field=false
	local spchk=false
	local dob=false
	local ct=3
	local g=Group.CreateGroup()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local sg=mg:FilterSelect(tp,c419.xyzfilter52653092,1,1,nil,tp,mg,c,ct,field,spchk)
		local tc=sg:GetFirst()
		field=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or tc:IsLocation(LOCATION_MZONE) or field
		if not xyzchkc and tc:IsType(TYPE_XYZ) then xyzchkc=tc end
		if tc:IsHasEffect(511002116) then
			tc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			spchk=true
		end
		if tc:IsHasEffect(511001175) then spchk=true end
		local eqg=tc:GetEquipGroup()
		local eqc=eqg:GetFirst()
		while eqc do
			if eqc:IsHasEffect(511001175) then
				mg:AddCard(eqc)
			end
			eqc=eqg:GetNext()
		end
		mg:RemoveCard(tc)
		ct=ct-1
		if tc:IsHasEffect(511001225) then ct=ct-1 spchk=true dob=true end
		if tc:IsHasEffect(511002793) then spchk=true end
		if xyzchkc then mg=mg:Filter(c419.xyzfilterchk52653092,tc,tc:GetRank()) end
		g:AddCard(tc)
	until ct<=0
	if dob and mg:GetCount()>0 and g:GetCount()==2 and Duel.SelectYesNo(tp,560) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g3=mg:FilterSelect(tp,c419.xyzfilter52653092,1,1,nil,tp,mg,c,ct,field,spchk)
		g:Merge(g3)
	end
	local sg=Group.CreateGroup()
	local tcc=g:GetFirst()
	while tcc do
		sg:Merge(tcc:GetOverlayGroup())
		tcc=g:GetNext()
	end
	g:Remove(Card.IsHasEffect,nil,511002116)
	g:Remove(Card.IsHasEffect,nil,511002115)
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
function c419.mfilter23187256(c,xyzc)
	if c:IsLocation(LOCATION_GRAVE) and not c:IsHasEffect(511002793) then return false end
	if c:IsOnField() and c:IsFacedown() then return false end
	return (c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:GetOverlayCount()>0 and c:IsCanBeXyzMaterial(xyzc))
		or c:IsHasEffect(511002116)
end
function c419.xyzfilterchk52653092(c,rk)
	return c:GetRank()==rk or c:IsHasEffect(511002116) or c:IsHasEffect(511001175)
end
function c419.xyzcon23187256(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local ct=2
	local maxc=63
	if min then
		ct=math.max(ct,min)
		maxc=max
	end
	local mg=nil
	if og then
		mg=og:Filter(c419.mfilter23187256,nil,c)
	else
		mg=Duel.GetMatchingGroup(c419.mfilter23187256,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
	end
	return maxc>=2 and mg:IsExists(c419.xyzfilter52653092,1,nil,tp,mg,c,ct,false,false)
end
function c419.xyzop23187256(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	if og and not min then
		g=og
	else
		local mg=nil
		if og then
			mg=og:Filter(c419.mfilter23187256,nil,c)
		else
			mg=Duel.GetMatchingGroup(c419.mfilter23187256,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c)
		end
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local maxc=64
		local ct=2
		if min then
			minc=math.max(ct,min)
			maxc=max
		end
		local xyzchkc
		local field=false
		local spchk=false
		g=Group.CreateGroup()
		repeat
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local sg=mg:FilterSelect(tp,c419.xyzfilter52653092,1,1,nil,tp,mg,c,ct,field,spchk)
			local tc=sg:GetFirst()
			field=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or tc:IsLocation(LOCATION_MZONE) or field
			if not xyzchkc and tc:IsType(TYPE_XYZ) then xyzchkc=tc end
			if tc:IsHasEffect(511002116) then
				tc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
				spchk=true
			end
			if tc:IsHasEffect(511001175) then spchk=true end
			local eqg=tc:GetEquipGroup()
			local eqc=eqg:GetFirst()
			while eqc do
				if eqc:IsHasEffect(511001175) then
					mg:AddCard(eqc)
				end
				eqc=eqg:GetNext()
			end
			mg:RemoveCard(tc)
			ct=ct-1
			maxc=maxc-1
			if tc:IsHasEffect(511001225) then ct=ct-1 spchk=true end
			if tc:IsHasEffect(511002793) then spchk=true end
			if xyzchkc then mg=mg:Filter(c419.xyzfilterchk52653092,tc,tc:GetRank()) end
			g:AddCard(tc)
		until ct<=0
		while mg:GetCount()>0 and maxc>0 and Duel.SelectYesNo(tp,560) do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local sg=mg:FilterSelect(tp,c419.xyzfilter52653092,1,1,nil,tp,mg,c,0,field,spchk)
			local tc=sg:GetFirst()
			field=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or tc:IsLocation(LOCATION_MZONE) or field
			if not xyzchkc and tc:IsType(TYPE_XYZ) then xyzchkc=tc end
			if tc:IsHasEffect(511002116) then
				tc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
				spchk=true
			end
			if tc:IsHasEffect(511001175) then spchk=true end
			local eqg=tc:GetEquipGroup()
			local eqc=eqg:GetFirst()
			while eqc do
				if eqc:IsHasEffect(511001175) then
					mg:AddCard(eqc)
				end
				eqc=eqg:GetNext()
			end
			mg:RemoveCard(tc)
			maxc=maxc-1
			if tc:IsHasEffect(511001225) then spchk=true end
			if tc:IsHasEffect(511002793) then spchk=true end
			if xyzchkc then mg=mg:Filter(c419.xyzfilterchk52653092,tc,tc:GetRank()) end
			g:AddCard(tc)
		end
	end
	local sg=Group.CreateGroup()
	local tcc=g:GetFirst()
	while tcc do
		sg:Merge(tcc:GetOverlayGroup())
		tcc=g:GetNext()
	end
	g:Remove(Card.IsHasEffect,nil,511002116)
	g:Remove(Card.IsHasEffect,nil,511002115)
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end

function c419.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsType,0,LOCATION_EXTRA,LOCATION_EXTRA,nil,TYPE_SYNCHRO)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(538)==0 then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetDescription(aux.Stringid(64382841,1))
			e1:SetCode(EFFECT_SPSUMMON_PROC)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetRange(LOCATION_EXTRA)
			e1:SetValue(SUMMON_TYPE_SYNCHRO)
			e1:SetCondition(c419.syncon2)
			e1:SetOperation(c419.synop2)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(538,nil,0,1) 	
		end
		tc=g:GetNext()
	end
end
function c419.syncon2(e,c,tuner,mg)
	if c==nil then return true end
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then return false end
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local tp=c:GetControler()
	local minct=2
	local g1=nil
	local g2=nil
	if mg then
		g1=mg:Filter(c419.matfilter1,nil,c,tp)
		g2=mg:Filter(c419.matfilter2,nil,c,tp)
	else
		g1=Duel.GetMatchingGroup(c419.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
		g2=Duel.GetMatchingGroup(c419.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		local tlv=tuner:GetSynchroLevel(c)
		if lv-tlv<=0 then return false end
		return g2:CheckWithSumEqual(c419.xyzlvfilter,lv-tlv,mt.minntct,mt.maxntct,c)
	end
	if not pe then
		return g1:IsExists(c419.synfilter,1,nil,c,lv,g2)
	else
		return c419.synfilter(pe:GetOwner(),c,lv,g2)
	end
end
function c419.synfilter(c,syncard,lv,g2)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local tlv
	if c:GetLevel()>0 then tlv=c:GetSynchroLevel(syncard)
		elseif c:IsHasEffect(511000538) then tlv=c:GetRank()
		else tlv=0 end
	if lv-tlv<=0 then return false end
	return mt.minntct and mt.maxntct and lv-tlv>0 and g2:CheckWithSumEqual(c419.xyzlvfilter,lv-tlv,mt.minntct,mt.maxntct,syncard)
end
function c419.xyzlvfilter(c,sync)
	if c:GetLevel()>0 then return c:GetSynchroLevel(sync)
	elseif c:GetRank()>0 and c:IsHasEffect(511000538) then return c:GetRank()
	else return 0 end
end
function c419.matfilter1(c,syncard,tp)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_TUNER) and c419.xyzsyncfilter(c,syncard) and mt.tuner_filter and mt.tuner_filter(c) 
		and (c:IsControler(tp) or c:IsHasEffect(EFFECT_SYNCHRO_MATERIAL))
end
function c419.matfilter2(c,syncard,tp)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsNotTuner() and c419.xyzsyncfilter(c,syncard) and mt.nontuner_filter and mt.nontuner_filter(c) 
		and (c:IsControler(tp) or c:IsHasEffect(EFFECT_SYNCHRO_MATERIAL))
end
function c419.xyzsyncfilter(c,syncard,mat)
	if mat then
		return c:IsCanBeSynchroMaterial(syncard,mat) or c:IsHasEffect(511000538)
	else
		return c:IsCanBeSynchroMaterial(syncard) or c:IsHasEffect(511000538)
	end
end
function c419.synop2(e,tp,eg,ep,ev,re,r,rp,c,tuner,mg)
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local g=Group.CreateGroup()
	local g1=nil
	local g2=nil
	if mg then
		g1=mg:Filter(c419.matfilter1,nil,c,tp)
		g2=mg:Filter(c419.matfilter2,nil,c,tp)
	else
		g1=Duel.GetMatchingGroup(c419.matfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
		g2=Duel.GetMatchingGroup(c419.matfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
	end
	local pe=Duel.IsPlayerAffectedByEffect(tp,EFFECT_MUST_BE_SMATERIAL)
	local lv=c:GetLevel()
	if tuner then
		g:AddCard(tuner)
		local lv1
		if tuner:GetLevel()>0 then lv1=tuner:GetSynchroLevel(c)
		elseif c:IsHasEffect(511000538) then lv1=tuner:GetRank()
		else lv1=0 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m2=g2:SelectWithSumEqual(tp,c419.xyzlvfilter,lv-lv1,mt.minntct,mt.maxntct,c)
		g:Merge(m2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner=nil
		if not pe then
			local t1=g1:FilterSelect(tp,c419.synfilter,1,1,nil,c,lv,g2)
			tuner=t1:GetFirst()
		else
			tuner=pe:GetOwner()
			Group.FromCards(tuner):Select(tp,1,1,nil)
		end
		g:AddCard(tuner)
		local lv1
		if tuner:GetLevel()>0 then lv1=tuner:GetSynchroLevel(c)
		elseif c:IsHasEffect(511000538) then lv1=tuner:GetRank()
		else lv1=0 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local m2=g2:SelectWithSumEqual(tp,c419.xyzlvfilter,lv-lv1,mt.minntct,mt.maxntct,c)
		g:Merge(m2)
	end
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_SYNCHRO)
end
function c419.op4(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsSetCard,0,0x13,0x13,nil,0xe6)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(227)==0 then
			local code=tc:GetOriginalCode()
			local mt=_G["c" .. code]
			if mt.spe==nil then
				if code==17141718 then
					local e1=Effect.CreateEffect(tc)
					e1:SetType(EFFECT_TYPE_IGNITION)
					e1:SetRange(LOCATION_HAND)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c17141718.cfilter,tp,LOCATION_MZONE,0,1,nil)
							and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
					end
				elseif code==81752019 then
					mt.spe=false
					mt.spcon=aux.FALSE()
				elseif code==54135423 then
					local e1=Effect.CreateEffect(tc)
					e1:SetType(EFFECT_TYPE_IGNITION)
					e1:SetRange(LOCATION_HAND)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c54135423.cfilter,tp,LOCATION_MZONE,0,1,nil)
							and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
					end
				elseif code==80630522 then
					local e1=Effect.CreateEffect(tc)
					e1:SetType(EFFECT_TYPE_IGNITION)
					e1:SetRange(LOCATION_HAND)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c80630522.cfilter,tp,LOCATION_MZONE,0,1,nil)
							and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
					end
				elseif code==16024176 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c16024176.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				elseif code==57261568 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c57261568.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				elseif code==94388754 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c94388754.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				elseif code==43413875 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c43413875.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				elseif code==21772453 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c21772453.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				elseif code==89818984 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c89818984.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				elseif code==16802689 then
					local e1=Effect.CreateEffect(tc)
					e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
					e1:SetType(EFFECT_TYPE_FIELD)
					e1:SetRange(LOCATION_HAND)
					e1:SetCode(EFFECT_SPSUMMON_PROC)
					e1:SetCondition(aux.FALSE)
					tc:RegisterEffect(e1)
					mt.spe=e1
					mt.spcon=function(c,e)
						if c==nil or not e then return false end
						local tp=c:GetControler()
						return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckReleaseGroup(tp,c16802689.hspfilter,1,nil)
							and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0xe6,c:GetOriginalType(),c:GetOriginalLevel(),
							c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalRace(),c:GetOriginalAttribute())
					end
				end
			end
			tc:RegisterFlagEffect(227,nil,0,1) 	
		end
		tc=g:GetNext()
	end
end

function c419.op5(e,tp,eg,ep,ev,re,r,rp)
	--ATK = 285, prev ATK = 284, ATK<=0 = 286
	--LVL = 585, prev LVL = 584
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0xff,0xff,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(285)==0 and tc:GetFlagEffect(286)==0 and tc:GetFlagEffect(585)==0 then
			local atk=tc:GetAttack()
			if atk<=0 then
				tc:RegisterFlagEffect(286,nil,0,0)
			else
				tc:RegisterFlagEffect(285,nil,0,1,atk)
				tc:RegisterFlagEffect(284,nil,0,1,atk)
			end
			local lv=tc:GetLevel()
			tc:RegisterFlagEffect(585,nil,0,1,lv)
			tc:RegisterFlagEffect(584,nil,0,1,lv)
		end	
		tc=g:GetNext()
	end
end
function c419.atkcfilter(c)
	if c:GetFlagEffect(285)==0 and c:GetFlagEffect(286)==0 then return false end
	return c:GetAttack()~=c:GetFlagEffectLabel(285) or (c:GetFlagEffect(286)>0 and c:GetAttack()>0)
end
function c419.lvcfilter(c)
	if c:GetFlagEffect(585)==0 then return false end
	return c:GetLevel()~=c:GetFlagEffectLabel(585)
end
function c419.atkraiseeff(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c419.atkcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g1=Group.CreateGroup() --change atk
	local g2=Group.CreateGroup() --gain atk
	local g3=Group.CreateGroup() --lose atk
	local g4=Group.CreateGroup() --gain atk from original
	local tc=g:GetFirst()
	while tc do
		local prevatk=0
		if tc:GetFlagEffect(285)>0 then prevatk=tc:GetFlagEffectLabel(285) end
		g1:AddCard(tc)
		if prevatk>tc:GetAttack() then
			g3:AddCard(tc)
		else
			g2:AddCard(tc)
			if prevatk<=tc:GetBaseAttack() and tc:GetAttack()>tc:GetBaseAttack() then
				g4:AddCard(tc)
			end
		end
		tc:ResetFlagEffect(284)
		tc:ResetFlagEffect(285)
		tc:ResetFlagEffect(286)
		if prevatk>0 then
			tc:RegisterFlagEffect(284,nil,0,1,prevatk)
		end
		if tc:GetAttack()>0 then
			tc:RegisterFlagEffect(285,nil,0,1,tc:GetAttack())
		else
			tc:RegisterFlagEffect(286,nil,0,0)
		end
		tc=g:GetNext()
	end
	Duel.RaiseEvent(g1,511001265,re,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g1,511001441,re,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g2,511001762,re,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g3,511000883,re,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g3,511009110,re,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g4,511002546,re,REASON_EFFECT,rp,ep,0)
	
	local lvg=Duel.GetMatchingGroup(c419.lvcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local lvc=lvg:GetFirst()
	while lvc do
		local prevlv=lvc:GetFlagEffectLabel(585)
		lvc:ResetFlagEffect(584)
		lvc:ResetFlagEffect(585)
		lvc:RegisterFlagEffect(584,nil,0,1,prevlv)
		lvc:RegisterFlagEffect(585,nil,0,1,lvc:GetLevel())
		lvc=lvg:GetNext()
	end
	Duel.RaiseEvent(lvg,511002524,re,REASON_EFFECT,rp,ep,0)
	
	Duel.RegisterFlagEffect(tp,285,RESET_CHAIN,0,1)
	Duel.RegisterFlagEffect(1-tp,285,RESET_CHAIN,0,1)
end
function c419.atkraiseadj(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,285)~=0 or Duel.GetFlagEffect(1-tp,285)~=0 then return end
	local g=Duel.GetMatchingGroup(c419.atkcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g1=Group.CreateGroup() --change atk
	local g2=Group.CreateGroup() --gain atk
	local g3=Group.CreateGroup() --lose atk
	local g4=Group.CreateGroup() --gain atk from original
	local tc=g:GetFirst()
	while tc do
		local prevatk=0
		if tc:GetFlagEffect(285)>0 then prevatk=tc:GetFlagEffectLabel(285) end
		g1:AddCard(tc)
		if prevatk>tc:GetAttack() then
			g3:AddCard(tc)
		else
			g2:AddCard(tc)
			if prevatk<=tc:GetBaseAttack() and tc:GetAttack()>tc:GetBaseAttack() then
				g4:AddCard(tc)
			end
		end
		tc:ResetFlagEffect(284)
		tc:ResetFlagEffect(285)
		tc:ResetFlagEffect(286)
		if prevatk>0 then
			tc:RegisterFlagEffect(284,nil,0,1,prevatk)
		end
		if tc:GetAttack()>0 then
			tc:RegisterFlagEffect(285,nil,0,1,tc:GetAttack())
		else
			tc:RegisterFlagEffect(286,nil,0,0)
		end
		tc=g:GetNext()
	end
	Duel.RaiseEvent(g1,511001265,e,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g2,511001762,e,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g3,511009110,e,REASON_EFFECT,rp,ep,0)
	Duel.RaiseEvent(g4,511002546,e,REASON_EFFECT,rp,ep,0)
	
	local lvg=Duel.GetMatchingGroup(c419.lvcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local lvc=lvg:GetFirst()
	while lvc do
		local prevlv=lvc:GetFlagEffectLabel(585)
		lvc:ResetFlagEffect(584)
		lvc:ResetFlagEffect(585)
		lvc:RegisterFlagEffect(584,nil,0,1,prevlv)
		lvc:RegisterFlagEffect(585,nil,0,1,lvc:GetLevel())
		lvc=lvg:GetNext()
	end
	Duel.RaiseEvent(lvg,511002524,e,REASON_EFFECT,rp,ep,0)
end
