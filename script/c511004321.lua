--Skull Skull Servant (DOR)
--scripted by GameMaster (GM)
function c511004321.initial_effect(c)
	--atk/def up 300 skullServant
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511004321,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e2:SetOperation(c511004321.operation)
	c:RegisterEffect(e2)
end
function c511004321.atktg(e,c)
	return c:GetFieldID()<=e:GetLabel() and c:IsCode(32274490)
end
function c511004321.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
		local mg,fid=g:GetMaxGroup(Card.GetFieldID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c511004321.atktg)
		e1:SetValue(300)
		e1:SetLabel(fid)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
	
