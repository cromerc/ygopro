--ＣＮｏ．９　天蓋妖星 カオス・ダイソン・スフィア
function c100000578.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,10),3)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000578,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c100000578.damtg1)
	e1:SetOperation(c100000578.damop1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000578,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c100000578.damcost)
	e2:SetTarget(c100000578.damtg2)
	e2:SetOperation(c100000578.damop2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c100000578.recon)
	e3:SetOperation(c100000578.reop)
	c:RegisterEffect(e3)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c100000578.indes)
	c:RegisterEffect(e6)
end
c100000578.xyz_number=9
function c100000578.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c100000578.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetHandler():GetOverlayCount()*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetHandler():GetOverlayCount()*500)
end
function c100000578.damop1(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,e:GetHandler():GetOverlayCount()*500,REASON_EFFECT)
end
function c100000578.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local ct=e:GetHandler():GetOverlayCount()
	e:SetLabel(ct)
	e:GetHandler():RemoveOverlayCard(tp,ct,ct,REASON_COST)
end
function c100000578.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()*800
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100000578.damop2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=e:GetLabel()*800
	Duel.Damage(p,dam,REASON_EFFECT)
end
function c100000578.recon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	 and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,1992816)
end
function c100000578.reop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetTarget(c100000578.atlimit)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BATTLE_END)
	e5:SetRange(LOCATION_MZONE)
	e5:SetReset(RESET_EVENT+0x1fe0000)
	e5:SetCondition(c100000578.rmcon)
	e5:SetTarget(c100000578.rmtg)
	e5:SetOperation(c100000578.rmop)
	c:RegisterEffect(e5)
end 
function c100000578.atlimit(e,c)
	return c~=e:GetHandler()
end
function c100000578.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local c=e:GetHandler()
	return d and (a==c or d==c)
end
function c100000578.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(tc)
end
function c100000578.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.SendtoGrave(mg,REASON_RULE)
		end
		Duel.Overlay(e:GetHandler(),tc)
	end
end
