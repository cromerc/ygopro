--Ｓｐ－スタンピング·クラッシュ
function c100100061.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100061.condition)
	e1:SetTarget(c100100061.target)
	e1:SetOperation(c100100061.activate)
	c:RegisterEffect(e1)
end
function c100100061.filter1(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c100100061.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return Duel.IsExistingMatchingCard(c100100061.filter1,tp,LOCATION_MZONE,0,1,nil) 
		 and tc and tc:GetCounter(0x91)>2
end
function c100100061.filter2(c)
	return c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c100100061.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c100100061.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100100061.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100100061.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100100061.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)==0 then return end
		Duel.Damage(p,500,REASON_EFFECT)
	end
end
