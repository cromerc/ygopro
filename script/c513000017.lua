--No.101 S・H・Ark Knight
function c513000017.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48739166,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c513000017.cost)
	e1:SetTarget(c513000017.target)
	e1:SetOperation(c513000017.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c513000017.reptg)
	c:RegisterEffect(e2)
	if not c513000017.global_check then
		c513000017.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c513000017.numchk)
		Duel.RegisterEffect(ge2,0)
	end
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c513000017.indes)
	c:RegisterEffect(e3)
	if not c513000017.global_check then
		c513000017.global_check=true
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c513000017.numchk)
		Duel.RegisterEffect(ge3,0)
	end
end
c513000017.xyz_number=101
function c513000017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c513000017.filter(c)
	return c:IsAbleToChangeControler() and not c:IsType(TYPE_TOKEN)
end
function c513000017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000017.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c513000017.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectMatchingCard(tp,c513000017.filter,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.HintSelection(g)
		if g:GetCount()>0 then
			local og=g:GetFirst():GetOverlayGroup()
			if og:GetCount()>0 then
				Duel.SendtoGrave(og,REASON_RULE)
			end
			Duel.Overlay(c,g)
		end
	end
end
function c513000017.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(48739166,1)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c513000017.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,48739166)
	Duel.CreateToken(1-tp,48739166)
end
function c513000017.indes(e,c)
	return not c:IsSetCard(0x48)
end