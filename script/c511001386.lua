--Violent Salvage
function c511001386.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001386.condition)
	e1:SetTarget(c511001386.target)
	e1:SetOperation(c511001386.activate)
	c:RegisterEffect(e1)
end
function c511001386.cfilter(c)
	return c:IsFaceup() and c:IsCode(511001385)
end
function c511001386.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001386.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511001386.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc1=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
	local tc2=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-2)
	local tc3=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-3)
	if chk==0 then return tc1 and tc1:IsAbleToHand() and tc2 and tc2:IsAbleToHand() and tc3 and tc3:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,Group.FromCards(tc1,tc2,tc3),3,0,0)
end
function c511001386.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc1=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
	local tc2=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-2)
	local tc3=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-3)
	if not tc1 or not tc1:IsAbleToHand() or not tc2 or not tc2:IsAbleToHand() or not tc3 
		or not tc3:IsAbleToHand() then return end
	local g=Group.FromCards(tc1,tc2,tc3)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_SUMMON)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
			e2:SetReset(RESET_EVENT+0x07c0000)
			tc:RegisterEffect(e2)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_SPSUMMON_CONDITION)
			e3:SetReset(RESET_EVENT+0x0f80000)
			tc:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e4:SetCode(EFFECT_CANNOT_TRIGGER)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			e4:SetValue(1)
			tc:RegisterEffect(e4)
			local e5=e4:Clone()
			e5:SetCode(EFFECT_CANNOT_ACTIVATE)
			tc:RegisterEffect(e5)
			tc=g:GetNext()
		end
	end
end
