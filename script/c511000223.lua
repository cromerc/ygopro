--Next World
function c511000223.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000223.target)
	e1:SetOperation(c511000223.operation)
	c:RegisterEffect(e1)
end
function c511000223.filter1(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsFaceup() and Duel.IsExistingMatchingCard(c511000223.filter2,tp,LOCATION_HAND,0,1,nil,lv)
end
function c511000223.filter2(c,lv)
	return c:GetLevel()==lv and c:IsSummonableCard()
end
function c511000223.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511000223.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c511000223.filter1,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000223.filter1,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000223.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local sc=Duel.SelectMatchingCard(tp,c511000223.filter2,tp,LOCATION_HAND,0,1,1,nil,tc:GetLevel()):GetFirst()
	if sc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(511000223,0))
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCondition(c511000223.ntcon)
		e1:SetReset(RESET_CHAIN)
		sc:RegisterEffect(e1)
		Duel.Summon(tp,sc,true,nil)
	end
end
function c511000223.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
