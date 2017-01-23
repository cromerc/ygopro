--Skill Twist
function c511001763.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001763.condition)
	e1:SetTarget(c511001763.target)
	e1:SetOperation(c511001763.activate)
	c:RegisterEffect(e1)
end
function c511001763.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_MONSTER) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	if ep==tp then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsLocation(LOCATION_MZONE)
end
function c511001763.filter(c,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c) and c:IsFaceup()
end
function c511001763.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001763.filter,tp,LOCATION_MZONE,0,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp) end
end
function c511001763.activate(e,tp,eg,ep,ev,re,r,rp)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511001763.filter,tp,LOCATION_MZONE,0,1,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.ChangeTargetCard(ev,g)
	end
end
