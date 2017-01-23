--Amulet Dragon
function c170000158.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,1784686,46986414,true,true)
    --Spell Power
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c170000158.target)
	e1:SetOperation(c170000158.operation)
	c:RegisterEffect(e1)
end
c170000158.dark_magician_list=true
function c170000158.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToRemove()
end
function c170000158.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c170000158.cfilter,tp,LOCATION_GRAVE,0,e:GetHandler())
	if chk==0 then return g:GetCount()>0 and g:FilterCount(Card.IsAbleToRemoveAsCost,nil)==g:GetCount() end
	e:SetLabel(g:GetCount())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c170000158.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*300)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
