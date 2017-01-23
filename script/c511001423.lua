--Glory of the Seven Emperors
function c511001423.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001423.target)
	e1:SetOperation(c511001423.activate)
	c:RegisterEffect(e1)
	--act qp in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511001423.handcon)
	c:RegisterEffect(e2)
end
function c511001423.handcon(e)
	local ph=Duel.GetCurrentPhase()
	return Duel.IsExistingMatchingCard(c511001423.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
		and ph>=0x08 and ph<=0x20
end
function c511001423.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296))
end
function c511001423.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001423.atfilter(c)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return no and no>=101 and no<=107 and c:IsFaceup() and c:IsSetCard(0x1048)
end
function c511001423.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c511001423.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001423.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511001423.atfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001423.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001423.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local g=Duel.GetMatchingGroup(c511001423.atfilter,tp,LOCATION_REMOVED,0,nil)
		if g:GetCount()>0 then
			Duel.Overlay(tc,g)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e3:SetCode(EVENT_PHASE+PHASE_END)
			e3:SetOperation(c511001423.lpop)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e3:SetCountLimit(1)
			e3:SetLabel(Duel.GetLP(1-tp))
			Duel.RegisterEffect(e3,tp)
		end
	end
end
function c511001423.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001423)
	if Duel.GetLP(1-tp)>e:GetLabel() then
		Duel.SetLP(tp,Duel.GetLP(1-tp)-e:GetLabel(),REASON_EFFECT)
	else
		Duel.SetLP(tp,e:GetLabel()-Duel.GetLP(1-tp),REASON_EFFECT)
	end
end
