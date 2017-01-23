--Necromancy
function c511001130.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001130.target)
	e1:SetOperation(c511001130.activate)
	c:RegisterEffect(e1)
end
function c511001130.filter1(c,e,tp)
	return c:IsType(TYPE_MONSTER)
end
function c511001130.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==1-tp and chkc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0 and Duel.IsExistingTarget(c511001130.filter1,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,0)
end
function c511001130.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local gct=Duel.GetMatchingGroupCount(Card.IsType,tp,0,LOCATION_GRAVE,nil,TYPE_MONSTER)
	if gct>=4 then
   		local g=Duel.GetMatchingGroup(c511001130.filter1,tp,0,LOCATION_GRAVE,nil):RandomSelect(tp,4)
		local tc=g:GetFirst()
		while tc do
    		Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
    		tc:RegisterFlagEffect(511001130,RESET_EVENT+0x17a0000,0,1)
    		tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
		else
			local g=Duel.GetMatchingGroup(c511001130.filter1,tp,0,LOCATION_GRAVE,nil):RandomSelect(tp,gct)
			local tc=g:GetFirst()
			while tc do
			Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
			tc:RegisterFlagEffect(511001130,RESET_EVENT+0x17a0000,0,1)
    		tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001130.drcon)
	e2:SetOperation(c511001130.operation)
	Duel.RegisterEffect(e2,tp)
end
function c511001130.drfilter(c,tp)
	return c:GetFlagEffect(511001130)~=0 and c:GetOwner()==tp and c:IsReason(REASON_DESTROY)
end
function c511001130.drcon(e,tp,eg,ep,ev,re,r,rp)
	return  eg:IsExists(c511001130.drfilter,1,nil,1-tp)
end
function c511001130.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:GetCount(c511001130.drfilter,nil,tp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local sc=g:GetFirst()
	while sc do
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e3:SetValue(-(ct*600))
		sc:RegisterEffect(e3)
		sc=g:GetNext()
	end
end
