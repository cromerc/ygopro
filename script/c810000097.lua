--Fluffal Sheep
--scripted by: UnknownGuest
function c810000097.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP,0)
	e1:SetCondition(c810000097.spcon)
	c:RegisterEffect(e1)
	--add Poly
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(810000097,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_NAGA)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCondition(c810000097.con)
	e2:SetTarget(c810000097.target)
	e2:SetOperation(c810000097.operation)
	c:RegisterEffect(e2)
end
function c810000097.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xa9)
end
function c810000097.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000097.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c810000097.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) or c:IsPreviousLocation(LOCATION_GRAVE)
end
function c810000097.filter(c)
	return c:GetCode()==24094653 and c:IsAbleToHand()
end
function c810000097.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000097.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c810000097.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.GetFirstMatchingCard(c810000097.filter,tp,LOCATION_DECK,0,nil)
	if tg then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end