--Hell Gift
function c511002736.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002736.condition)
	e1:SetTarget(c511002736.target)
	e1:SetOperation(c511002736.activate)
	c:RegisterEffect(e1)
end
function c511002736.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<=1
end
function c511002736.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c511002736.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c511002736.damop)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c511002736.checkop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	Duel.RegisterEffect(e3,tp)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	Duel.RegisterEffect(e4,tp)
end
function c511002736.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,3000,REASON_EFFECT)
end
function c511002736.cfilter(c,tp)
	return (c:IsCode(36029076) or c:IsSetCard(0x21b)) and c:IsFaceup() and c:GetSummonPlayer()==tp
end
function c511002736.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511002736.cfilter,1,nil,tp) then
		if e:GetLabelObject() then
			e:GetLabelObject():Reset()
		end
		e:Reset()
	end
end
