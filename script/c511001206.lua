--Clone Slime
function c511001206.initial_effect(c)
	--be target
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetDescription(aux.Stringid(316000129,0))
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCost(c511001206.cost)
	e1:SetTarget(c511001206.target)
	e1:SetOperation(c511001206.operation)
	c:RegisterEffect(e1)
end
function c511001206.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511001206.filter(c,e,tp)
	return (c:IsSetCard(0x207) or c:IsCode(46821314) or c:IsCode(68638985) or c:IsCode(18914778) or c:IsCode(3918345) or c:IsCode(100000705) or c:IsCode(100000706) or c:IsCode(31709826))
		 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001206.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511001206.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511001206.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511001206.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c511001206.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local bp=0
		if e:GetHandler():IsPreviousPosition(POS_FACEUP_ATTACK) then
			bp=POS_FACEUP_ATTACK
		else
			bp=POS_FACEUP_DEFENSE
		end
		Duel.SpecialSummon(tc,0,tp,tp,false,false,bp)
		Duel.ChangeAttackTarget(tc)
	end
end
