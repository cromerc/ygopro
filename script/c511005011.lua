--Negative Energy
--  By Shad3

local scard=c511005011

function scard.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetTarget(scard.act_tg)
	e1:SetOperation(scard.act_op)
	c:RegisterEffect(e1)
end

function scard.act_fil(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end

function scard.act_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.act_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(scard.act_fil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,0,0,0)
end

function scard.act_op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(scard.act_fil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		local c=e:GetHandler()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(tc:GetAttack()*2)
			tc:RegisterEffect(e1)
			tc=tg:GetNext()
		end
	end
end