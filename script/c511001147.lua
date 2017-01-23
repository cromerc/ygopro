--Pumpking the King of Ghosts
function c511001147.initial_effect(c)  
   --atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511001147.target)
	e1:SetValue(c511001147.val1)
	c:RegisterEffect(e1)
	--defup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c511001147.target)
	e2:SetValue(c511001147.val2)
	c:RegisterEffect(e2)
	--10% increase each standby
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001147,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCondition(c511001147.atkcon)
	e3:SetOperation(c511001147.atkop)
	c:RegisterEffect(e3)
end
function c511001147.target(e,c)
	return c:IsRace(RACE_ZOMBIE) and  c~=e:GetHandler()
end
function c511001147.val1(e,c)
	return c:GetBaseAttack()*0.1
end
function c511001147.val2(e,c)
	return c:GetBaseDefense()*0.1
end
function c511001147.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511001147.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
    for i=0,4 do
		local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
		if tc and tc:IsRace(RACE_ZOMBIE) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(tc:GetBaseAttack()*0.1)
			tc:RegisterEffect(e1,true)
	    	local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			e2:SetValue(tc:GetBaseDefense()*0.1)
			tc:RegisterEffect(e2,true)
		end
	end
	for i=0,4 do
		local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,i)
		if tc and tc:IsRace(RACE_ZOMBIE) and tc:IsFaceup() then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(tc:GetBaseAttack()*0.1)
			tc:RegisterEffect(e2,true)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_UPDATE_DEFENSE)
			e3:SetValue(tc:GetBaseDefense()*0.1)
			tc:RegisterEffect(e3,true)
		end
	end
end
