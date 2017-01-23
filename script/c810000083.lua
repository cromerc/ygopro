--Dream Cicada
--scripted by: UnknownGuest
function c810000083.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c810000083.spcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--pos change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(810000083,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c810000083.poscon)
	e2:SetTarget(c810000083.postg)
	e2:SetOperation(c810000083.posop)
	c:RegisterEffect(e2)
end
function c810000083.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsRace(RACE_INSECT)
end
function c810000083.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c810000083.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c810000083.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c810000083.posfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsRace(RACE_INSECT)
end
function c810000083.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c810000083.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000083.posfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	local g=Duel.SelectTarget(tp,c810000083.posfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c810000083.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end
