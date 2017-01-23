--Session Draw
function c511001447.initial_effect(c)
	function aux.AddXyzProcedure(c,f,lv,ct,alterf,desc,maxct,op)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f then
			mt.xyz_filter=function(mc) return mc and f(mc) end
		else
			mt.xyz_filter=function(mc) return true end
		end
		mt.minxyzct=ct
		if not maxct then
			mt.maxxyzct=ct
		else
			if maxct==5 and code~=14306092 and code~=63504681 and code~=23776077 then
				mt.maxxyzct=99
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
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)	
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001447.activate)
	c:RegisterEffect(e1)
end
function c511001447.activate(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DRAW)	
	e1:SetCountLimit(1)
	if Duel.GetTurnPlayer()==tp and ph==PHASE_DRAW then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c511001447.con)
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1)
	end
	e1:SetOperation(c511001447.op)
	Duel.RegisterEffect(e1,tp)
end
function c511001447.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c511001447.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg) and (c.minxyzct==2 or c.maxxyzct>=2)
end
function c511001447.op(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or Duel.GetCurrentPhase()~=PHASE_DRAW or Duel.GetTurnPlayer()~=tp 
		or bit.band(r,REASON_RULE)==0 then return end
	Duel.Hint(HINT_CARD,0,511001447)
	local tc1=eg:GetFirst()
	local tc2=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc1 and tc2 then
		local g=Group.FromCards(tc1,tc2)
		Duel.ConfirmCards(1-tp,g)
		if tc1:IsType(TYPE_MONSTER) and tc2:IsType(TYPE_MONSTER) and tc1:GetLevel()==tc2:GetLevel() then
			local xyzg=Duel.GetMatchingGroup(c511001447.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
			if xyzg:GetCount()>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
				xyz:SetMaterial(g)
				Duel.Overlay(xyz,g)
				Duel.SpecialSummon(xyz,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
				xyz:CompleteProcedure()
			end
		end
		Duel.ShuffleHand(tp)
	end
	Duel.ShuffleHand(tp)
end
