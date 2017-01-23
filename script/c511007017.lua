--coded by Lyris
--fixed by MLD
--Comic Field
function c511007017.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--If exactly 1 "Comics Hero" monster would be destroyed by battle, it gains 500 ATK instead. [Puzzle Reborn & Crystal Protector]
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTarget(c511007017.indtg)
	e2:SetValue(c511007017.indval)
	c:RegisterEffect(e2)
end
function c511007017.dfilter(c)
	return c:IsFaceup() and c:IsOnField() and c:IsReason(REASON_BATTLE) and (c:IsCode(77631175) or c:IsCode(13030280))
end
function c511007017.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:FilterCount(c511007017.dfilter,nil)==1 end
	Duel.Hint(HINT_CARD,0,511007017)
	local g=eg:Filter(c511007017.dfilter,nil)
	local tc=g:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(500)
	tc:RegisterEffect(e1)
	return true
end
function c511007017.indval(e,c)
	return c:IsFaceup() and c:IsOnField() and c:IsReason(REASON_BATTLE) and (c:IsCode(77631175) or c:IsCode(13030280))
end
