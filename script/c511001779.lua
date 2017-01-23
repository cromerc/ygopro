--Number 19: Freezerdon (anime)
function c511001779.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--reattach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001779,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511001779.cost)
	e1:SetTarget(c511001779.target)
	e1:SetOperation(c511001779.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511001779.indes)
	c:RegisterEffect(e2)
	if not c511001779.global_check then
		c511001779.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001779.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001779.xyz_number=19
function c511001779.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001779.filter(c)
	local g=c:GetMaterial()
	g=g:Filter(c511001779.mfilter,nil)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and g:GetCount()>0
end
function c511001779.mfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001779.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001779.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
end
function c511001779.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511001779.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local mat=tc:GetMaterial():Filter(c511001779.mfilter,nil)
		if not tc:IsImmuneToEffect(e) then
			Duel.Overlay(tc,mat)
		end
	end
end
function c511001779.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,55067058)
	Duel.CreateToken(1-tp,55067058)
end
function c511001779.indes(e,c)
	return not c:IsSetCard(0x48)
end
