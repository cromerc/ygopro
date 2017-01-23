--Icicle Sacrifice
function c511001349.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001349.target)
	e1:SetOperation(c511001349.activate)
	c:RegisterEffect(e1)
end
function c511001349.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001350,0,0x4011,0,0,1,RACE_AQUA,ATTRIBUTE_WATER) end
	local dis=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	e:SetLabel(dis)
end
function c511001349.disop(e,tp)
	return e:GetLabel()
end
function c511001349.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetOperation(c511001349.disop)
	e1:SetLabel(e:GetLabel())
	Duel.RegisterEffect(e1,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001350,0,0x4011,0,0,1,RACE_AQUA,ATTRIBUTE_WATER) then return end
	local token=Duel.CreateToken(tp,511001350)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e2,true)
end
