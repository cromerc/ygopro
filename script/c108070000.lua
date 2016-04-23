--ＲＤＭ－ヌメロン・フォール
function c108070000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c108070000.target)
	e1:SetOperation(c108070000.activate)
	c:RegisterEffect(e1)
end
function c108070000.filter(c,e,tp)
	local rank=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x7f)
	 and Duel.IsExistingMatchingCard(c108070000.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,rank,e,tp)
end
function c108070000.xyzfilter(c,rank,e,tp)
	return c:GetRank()<rank and c:IsSetCard(0x7f)
	 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,true,false)
end
function c108070000.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c108070000.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c108070000.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c108070000.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c108070000.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local sg=Group.CreateGroup()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
		local rank=tc:GetRank()
		sg:AddCard(tc)
		local xyzg=Duel.GetMatchingGroup(c108070000.xyzfilter,tp,LOCATION_EXTRA,0,nil,rank,e,tp)
		if xyzg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
			local mg=tc:GetOverlayGroup()
			xyz:SetMaterial(sg)
			Duel.BreakEffect()
			if mg:GetCount()~=0 then
				Duel.Overlay(xyz,mg)
			end
			Duel.Overlay(xyz,sg)
			Duel.SpecialSummonStep(xyz,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
			--negate
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_ATTACK_ANNOUNCE)
			e1:SetOperation(c108070000.negop1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			xyz:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_BE_BATTLE_TARGET)
			e1:SetOperation(c108070000.negop2)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			xyz:RegisterEffect(e2)
			Duel.SpecialSummonComplete()		
			xyz:CompleteProcedure()
	end
end
function c108070000.negop1(e,tp,eg,ep,ev,re,r,rp)
	local d=e:GetHandler():GetBattleTarget()
	if d then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		d:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		d:RegisterEffect(e2)
	end
end
function c108070000.negop2(e,tp,eg,ep,ev,re,r,rp)
	local a=e:GetHandler():GetBattleTarget()
	if a then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e2)
	end
end