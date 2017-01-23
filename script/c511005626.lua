--Curse of Dragon (DOR)
--scripted by GameMaster (GM)
function c511005626.initial_effect(c)
	--field treated as wasteland
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetOperation(c511005626.operation)
	c:RegisterEffect(e1)
end
function c511005626.filter(c)
    return c and c:IsCode(code) and c:IsFaceUp()
end
function c511005626.condition(e)
    return
      not c511005626.filter(Duel.GetFieldCard(0,LOCATION_SZONE,5)) and
      not c511005626.filter(Duel.GetFieldCard(1,LOCATION_SZONE,5))
end

function c511005626.atktg(e,c)
    return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_ZOMBIE+RACE_ROCK+RACE_DINOSAUR)
end


function c511005626.operation(e)
    local c=e:GetHandler()
    local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    e1:SetTarget(c511005626.atktg)
    e1:SetCondition(c511005626.condition)
    e1:SetValue(c511005626.val)
    e1:SetLabel(fid)
    e1:SetReset(RESET_EVENT+0x1ff0000)
    c:RegisterEffect(e1)
    --Def
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetCondition(c511005626.condition)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
    --field
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCondition(c511005626.condition)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_CHANGE_ENVIRONMENT)
    e3:SetValue(23424603)
    c:RegisterEffect(e3)
   end
    
function c511005626.val(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_ZOMBIE+RACE_ROCK+RACE_DINOSAUR)>0 then return 200
	else return 0 end
end