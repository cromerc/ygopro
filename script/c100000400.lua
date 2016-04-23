--ＲＵＭ－バリアンズ・フォース
function c100000400.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000400.target)
	e1:SetOperation(c100000400.activate)
	c:RegisterEffect(e1)
end
function c100000400.filter(c,e,tp)
	local rank=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) 
	 and Duel.IsExistingMatchingCard(c100000400.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,rank,e,tp,c:GetCode())
end
function c100000400.xyzfilter(c,rank,e,tp,code)
    if c:IsCode(6165656) and code~=48995978 then return false end
	return c:GetRank()==rank+1 and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073))
	 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,true,false)
end
function c100000400.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100000400.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000400.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c100000400.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000400.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local sg=Group.CreateGroup()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
		local rank=tc:GetRank()
		sg:AddCard(tc)
		local xyzg=Duel.GetMatchingGroup(c100000400.xyzfilter,tp,LOCATION_EXTRA,0,nil,rank,e,tp,tc:GetCode())
		if xyzg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
			local mg=tc:GetOverlayGroup()
			xyz:SetMaterial(sg)
			Duel.BreakEffect()
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
			e3:SetProperty(EFFECT_FLAG_DELAY)
			e3:SetCode(EVENT_SPSUMMON_SUCCESS)
			e3:SetLabelObject(xyz)
			e3:SetCondition(c100000400.spcon)
			e3:SetTarget(c100000400.sptg)
			e3:SetOperation(c100000400.spop)
			e3:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e3,tp)
			if mg:GetCount()~=0 then
				Duel.Overlay(xyz,mg)
			end
			Duel.Overlay(xyz,sg)
			Duel.SpecialSummonStep(xyz,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetProperty(EFFECT_FLAG_INITIAL)
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_BATTLED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCondition(c100000400.con)
			e1:SetOperation(c100000400.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			xyz:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_ATTACK_ANNOUNCE)
			e2:SetOperation(c100000400.oop)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			xyz:RegisterEffect(e2)
			xyz:RegisterFlagEffect(100000400,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			Duel.SpecialSummonComplete()		
			xyz:CompleteProcedure()
	end
end
function c100000400.cfilter(c,tp,tc)
	return c:IsFaceup() and c:IsControler(tp) and c==tc and c:GetFlagEffect(100000400)~=0
end
function c100000400.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsExists(c100000400.cfilter,1,nil,tp,tc)
end
function c100000400.overfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c100000400.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c100000400.overfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c100000400.overfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c100000400.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local xyz=e:GetLabelObject()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsControler(1-tp) or tc:IsImmuneToEffect(e)
	 or xyz:GetLocation()~=LOCATION_MZONE then return end
	local desmg=tc:GetOverlayGroup()
	if desmg:GetCount()~=0 then
		Duel.Overlay(xyz,desmg)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-desmg:GetCount()*300)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c100000400.con(e)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	local bc=c:GetBattleTarget()
	if not bc then return end
	local bct=0
	if bc:GetPosition()==POS_FACEUP_ATTACK then
		bct=bc:GetAttack()
	else bct=bc:GetDefence()+1 end
	return c:IsRelateToBattle() and c:GetPosition()==POS_FACEUP_ATTACK 
	 and atk>=bct and not bc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c100000400.op(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	Duel.Destroy(bc,REASON_BATTLE)
	bc:SetStatus(STATUS_BATTLE_DESTROYED,true)
end
function c100000400.oop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetOperation(c100000400.resetop)
		e2:SetLabelObject(e1)
		bc:RegisterEffect(e2)
	end
end
function c100000400.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():Reset()
	e:Reset()
end