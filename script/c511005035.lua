--Double Buster Swords
--  By Shad3

local scard=c511005035

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(scard.eq_lmt)
	c:RegisterEffect(e2)
	--2 ATKs
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
	--Destroy End Phase
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetCountLimit(1)
	e5:SetDescription(1101)
	e5:SetOperation(scard.des_op)
	c:RegisterEffect(e5)
end

function scard.eq_fil(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and scard.eq_fil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(scard.eq_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,scard.eq_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
	end
end

function scard.eq_lmt(e,c)
	return c:IsRace(RACE_WARRIOR)
end

function scard.des_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end