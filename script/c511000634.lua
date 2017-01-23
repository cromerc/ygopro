--困惑のマスク
function c511000634.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511000634.condition)
	e1:SetTarget(c511000634.target)
	e1:SetOperation(c511000634.activate)
	c:RegisterEffect(e1)
end
function c511000634.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return bt:GetControler()==c:GetControler()
end
function c511000634.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,Duel.GetAttacker())
end
function c511000634.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end	
