--Ｓｐ－リアクター・ポッド
function c100100127.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100127.con)
	e1:SetTarget(c100100127.target)
	e1:SetOperation(c100100127.activate)
	c:RegisterEffect(e1)
end
function c100100127.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>2
end
function c100100127.filter(c)
	return c:IsAttackBelow(1000) and c:IsFaceup()
end
function c100100127.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c100100127.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100100127.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100100127.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100100127.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
end
