--Goddess Skuld's Oracle
function c511000419.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Look at TOP of DECK
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000419,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511000419.target)
	e2:SetOperation(c511000419.activate)
	c:RegisterEffect(e2)
	end
function c511000419.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function c511000419.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,1-tp,3)
end
