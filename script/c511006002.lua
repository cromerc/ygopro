--Exus Summon
function c511006002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511006002.condition)
	e1:SetTarget(c511006002.target)
	e1:SetOperation(c511006002.activate)
	c:RegisterEffect(e1)
end
function c511006002.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup() and tc:IsAbleToHand()
end
function c511006002.filter(c,tc,e,tp)
	return c:GetAttack()<tc:GetAttack() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511006002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.IsExistingMatchingCard(c511006002.filter,tp,LOCATION_HAND,0,1,nil,tc,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511006002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	
	if Duel.SendtoHand(tc,nil,REASON_EFFECT)==1 then
		local c = Duel.SelectMatchingCard(tp,c511006002.filter,tp,LOCATION_HAND,0,1,1,nil,tc,e,tp)
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end		
end
