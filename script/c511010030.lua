--No.30 破滅のアシッド・ゴーレム
function c511010030.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),3,2)
	c:EnableReviveLimit()
	--remove material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81330115,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511010030.rmcon)
	e1:SetTarget(c511010030.rmtg)
	e1:SetOperation(c511010030.rmop)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c511010030.atcon)
	c:RegisterEffect(e2)
	--material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511010030,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c511010030.olcon)
	e3:SetTarget(c511010030.oltg)
	e3:SetOperation(c511010030.olop)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(c511010030.indes)
	c:RegisterEffect(e4)
	if not c511010030.global_check then
		c511010030.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010030.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010030.xyz_number=30
function c511010030.atcon(e)
	return e:GetHandler():GetOverlayCount()==0
end
function c511010030.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511010030.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetHandler():GetOverlayCount()==0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,2000)
	end
end
function c511010030.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) and Duel.SelectYesNo(tp,aux.Stringid(81330115,1)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	else
		Duel.Damage(tp,2000,REASON_EFFECT)
	end
end

function c511010030.olcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()==0
end
function c511010030.oltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return true end
	if e:GetHandler():GetOverlayCount()==0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,2000)
	end
end
function c511010030.olop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.Damage(tp,2000,REASON_EFFECT)
		end
	end
end
function c511010030.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,81330115)
	Duel.CreateToken(1-tp,81330115)
end
function c511010030.indes(e,c)
return not c:IsSetCard(0x48)
end