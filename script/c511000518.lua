--Prism Wall
function c511000518.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000518,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000518.condition1)
	e1:SetTarget(c511000518.target1)
	e1:SetOperation(c511000518.activate1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000518,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511000518.condition2)
	e2:SetTarget(c511000518.target2)
	e2:SetOperation(c511000518.activate2)
	c:RegisterEffect(e2)
end
function c511000518.condition1(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsFaceup() and d:IsControler(tp)
end
function c511000518.filter1(c,e)
	return c:IsCanBeEffectTarget(e) and c:IsFaceup()
end
function c511000518.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ag=eg:GetFirst():GetAttackableTarget()
	if chkc then return ag:IsContains(chkc) and c511000518.filter1(chkc,e) end
	local at=Duel.GetAttackTarget()
	if chk==0 then return ag:IsExists(c511000518.filter1,1,at,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=ag:FilterSelect(tp,c511000518.filter1,1,1,at,e)
	Duel.SetTargetCard(g)
end
function c511000518.activate1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
		local dam=tc:GetAttack()
		Duel.Damage(1-tp,dam,REASON_EFFECT,true)
		Duel.Damage(tp,dam,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
function c511000518.condition2(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_MONSTER) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup()
end
function c511000518.filter2(c,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c) and c:IsFaceup()
end
function c511000518.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and tf(re,rp,ceg,cep,cev,cre,cr,crp,0,chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000518.filter2,tp,LOCATION_MZONE,0,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp) and e:GetLabelObject():IsFaceup() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000518.filter2,tp,LOCATION_MZONE,0,1,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp)
end
function c511000518.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetCount()>0 and g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
		local dam=g:GetFirst():GetAttack()
		Duel.Damage(1-tp,dam,REASON_EFFECT,true)
		Duel.Damage(tp,dam,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
