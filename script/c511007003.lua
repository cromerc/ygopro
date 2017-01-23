--coded by Lyris
--Briar Pin-Seal
function c511007003.initial_effect(c)
	--When this card is activated; pick 1 card in your opponent's hand at random.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511007003.target)
	e1:SetOperation(c511007003.activate)
	c:RegisterEffect(e1)
	--That card cannot be used [Prohibition]
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_FORBIDDEN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0x7f,0x7f)
	e2:SetTarget(c511007003.bantg)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--It cannot be discarded. [Narukami Waterfall]
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_DISCARD_HAND)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c511007003.bantg)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
end
function c511007003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c511007003.activate(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1):GetFirst()
	e:SetLabelObject(ac)
end
function c511007003.bantg(e,c)
	return c==e:GetLabelObject():GetLabelObject()
end
