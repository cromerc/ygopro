--リバイバルスライム
function c511000115.initial_effect(c)
	--reborn preparation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000115,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000115.spcon)
	e1:SetCost(c511000115.spcost)
	e1:SetOperation(c511000115.spop)
	c:RegisterEffect(e1)
	--reborn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000115.spcon2)
	e2:SetOperation(c511000115.spop2)
	c:RegisterEffect(e2)
end
function c511000115.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c511000115.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,0) end
	Duel.PayLPCost(tp,0)
end
function c511000115.spop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511000115,RESET_EVENT+0x1fe0000,0,0)
end
function c511000115.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(12300)>0
end
function c511000115.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:ResetFlagEffect(511000115)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
end
