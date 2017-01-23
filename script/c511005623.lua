--Gogogo Dexia (Manga)
--scripted by GameMaster (GM)
function c511005623.initial_effect(c)
	--cannot atk earth monsters
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetRange(LOCATION_MZONE)
	e0:SetTargetRange(0,LOCATION_MZONE)
	e0:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e0:SetValue(c511005623.atlimit)
	e0:SetCondition(c511005623.condition2)
	c:RegisterEffect(e0)
	--Pos Change
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_POSITION)
    e1:SetCondition(c511005623.condition)
    e1:SetValue(POS_FACEUP_DEFENSE)
    c:RegisterEffect(e1)
end
function c511005623.atlimit(e,c)
	return c==e:GetHandler() and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c511005623.condition2(e,tp,eg,ep,ev,re,r,rp)																																																
	local tp=e:GetHandlerPlayer()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c511005623.filter,tp,LOCATION_MZONE,0,1,nil,511005624)
	and Duel.IsExistingMatchingCard(c511005623.filter,tp,LOCATION_MZONE,0,1,nil,511005623)
end

function c511005623.filter(c,code)
	return c:IsCode(code) and c:IsFaceup()
end

function c511005623.condition(e)
    return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,511005624)
end