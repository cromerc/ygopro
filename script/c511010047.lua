--No.47 ナイトメア・シャーク
function c511010047.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--charge
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31320433,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c511010047.mattg)
	e1:SetOperation(c511010047.matop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31320433,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511010047.dacon)
	e2:SetCost(c511010047.dacost)
	e2:SetTarget(c511010047.datg)
	e2:SetOperation(c511010047.daop)
	c:RegisterEffect(e2)
	--battle indestructable
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
e2:SetValue(c511010047.indes)
c:RegisterEffect(e2)
	if not c511010047.global_check then
		c511010047.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010047.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010047.xyz_number=47
function c511010047.matfilter(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and not c:IsType(TYPE_TOKEN) and c:GetLevel()==3 and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511010047.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511010047.matfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
end
function c511010047.matop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c511010047.matfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>=0 then
		Duel.Overlay(e:GetHandler(),g)
	end
end
function c511010047.dacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c511010047.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010047.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511010047.datg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511010047.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511010047.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511010047.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c511010047.ftarget)
	e1:SetLabel(g:GetFirst():GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511010047.daop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511010047.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c511010047.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,31320433)
	Duel.CreateToken(1-tp,31320433)
end
function c511010047.indes(e,c)
return not c:IsSetCard(0x48)
end
