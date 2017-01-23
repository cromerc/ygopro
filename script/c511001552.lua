--Fusion Dispersal
function c511001552.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001552.condition)
	e1:SetTarget(c511001552.target)
	e1:SetOperation(c511001552.activate)
	c:RegisterEffect(e1)
end
function c511001552.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsType(TYPE_FUSION)
end
function c511001552.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chkc then return chkc==a end
	if chk==0 then return a and a:IsOnField() and a:IsCanBeEffectTarget(e) and a:IsAbleToExtra() end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,a,1,0,0)
end
function c511001552.mgfilter(c,e,tp,fusc)
	return c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x40008)~=0x40008 or c:GetReasonCard()~=fusc
		or not c:IsCanBeSpecialSummoned(e,0,1-tp,false,false,POS_FACEUP,1-tp) 
		or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001552.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)==0 then return end
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	if bit.band(sumtype,SUMMON_TYPE_FUSION)~=SUMMON_TYPE_FUSION or mg:GetCount()==0
		or mg:GetCount()>ft
		or mg:IsExists(c511001552.mgfilter,1,nil,e,tp,tc) then
		sumable=false
	end
	if sumable then
		Duel.BreakEffect()
		if Duel.SpecialSummon(mg,0,tp,1-tp,false,false,POS_FACEUP) then
			local mtg=mg:GetMaxGroup(Card.GetAttack)
			local sg=mtg:GetFirst()
			if mtg:GetCount()>1 then
				Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(17874674,0))
				local stg=mtg:Select(tp,1,1,nil)
				sg=stg:GetFirst()
				Duel.HintSelection(stg)
			end
			local atk=sg:GetAttack()
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
