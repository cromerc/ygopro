--Commande duel 25
function c95200024.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_COIN)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200024.target)
	e1:SetOperation(c95200024.operation)
	c:RegisterEffect(e1)
end
function c95200024.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c95200024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,PLAYER_ALL,1)
end
function c95200024.operation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c95200024.filter,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c95200024.filter,1-tp,LOCATION_MZONE,0,nil)
	local ct1=g1:GetCount()
	local ct2=g2:GetCount()
	if ct1==0 and ct2==0 then return end
	local op1
	local op2
	if ct1>0 then
		op1=Duel.SelectYesNo(tp,aux.Stringid(95200024,0))
	end
	if ct2>0 then
		op2=Duel.SelectYesNo(1-tp,aux.Stringid(95200024,0))
	end
	--true=wearing, false=not wearing
	local res=Duel.TossCoin(tp,1)
	local check
	if res==1 then
		check=true
	else
		check=false
	end
	if ct1>0 then
		if ((op1 and check) or (not op1 and not check)) and Duel.SelectYesNo(tp,aux.Stringid(95200024,1)) then
			local lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
			local tc=g1:GetFirst()
			while tc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetValue(lv)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
				tc=g1:GetNext()
			end
		end
	end
	if ct2>0 then
		if ((op2 and check) or (not op2 and not check)) and Duel.SelectYesNo(1-tp,aux.Stringid(95200024,1)) then
			local lv=Duel.AnnounceNumber(1-tp,1,2,3,4,5,6,7,8,9,10,11,12)
			local tc=g2:GetFirst()
			while tc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetValue(lv)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
				tc=g2:GetNext()
			end
		end
	end
end
