--Performage Magic Tactician
function c511002681.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63251695,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c511002681.discon)
	e2:SetCost(c511002681.discost)
	e2:SetTarget(c511002681.distg)
	e2:SetOperation(c511002681.disop)
	c:RegisterEffect(e2)
	--replace
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21501505,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002681.repcon)
	e1:SetCost(c511002681.repcost)
	e1:SetTarget(c511002681.reptg)
	e1:SetOperation(c511002681.repop)
	c:RegisterEffect(e1)
end
function c511002681.tgfilter(c,tp)
	return c:IsLocation(LOCATION_SZONE) and c:IsControler(tp) and c:GetSequence()<5
end
function c511002681.discon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c511002681.tgfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c511002681.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lc=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rc=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	if chk==0 then return (not lc or lc:IsDestructable()) and (not rc or rc:IsDestructable()) end
	local g=Group.FromCards(lc,rc)
	Duel.Destroy(g,REASON_COST)
end
function c511002681.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511002681.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c511002681.repcon(e,tp,eg,ep,ev,re,r,rp)
	if e==re or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsOnField() and tc:IsLocation(LOCATION_MZONE)
end
function c511002681.cfilter(c,tp,re,rp,tf,ceg,cep,cev,cre,cr,crp,tc)
	return c:IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c511002681.filter,tp,LOCATION_MZONE,0,1,c,re,rp,tf,ceg,cep,cev,cre,cr,crp,tc)
end
function c511002681.filter(c,re,rp,tf,ceg,cep,cev,cre,cr,crp,tc)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c) and c~=tc
end
function c511002681.repcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tf=re:GetTarget()
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002681.cfilter,tp,LOCATION_MZONE,0,1,nil,tp,re,rp,tf,ceg,cep,cev,cre,cr,crp,tc)
		and c:IsAbleToGraveAsCost() end
	local g=Duel.SelectMatchingCard(tp,c511002681.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp,re,rp,tf,ceg,cep,cev,cre,cr,crp,tc)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002681.reptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	local tc=e:GetLabelObject()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002681.filter(chkc,re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	if chk==0 then return Duel.IsExistingTarget(c511002681.filter,tp,LOCATION_MZONE,0,1,tc,re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002681.filter,tp,LOCATION_MZONE,0,1,1,tc,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	e:SetLabelObject(nil)
end
function c511002681.repop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end
