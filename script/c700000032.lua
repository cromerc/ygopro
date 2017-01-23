--Scripted by Eerie Code
--Thorn Observer - Zuma
function c700000032.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,nil,aux.NonTuner(Card.IsSetCard,0x513))
	c:EnableReviveLimit()
	--Place Counter
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c700000032.pccon)
	e1:SetTarget(c700000032.pctg)
	e1:SetOperation(c700000032.pcop)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c700000032.atktg)
	c:RegisterEffect(e2)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCountLimit(1)
	e4:SetTarget(c700000032.damtg)
	e4:SetOperation(c700000032.damop)
	c:RegisterEffect(e4)
	--No battle damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCost(c700000032.nbcost)
	e5:SetTarget(c700000032.nbtg)
	e5:SetOperation(c700000032.nbop)
	c:RegisterEffect(e5)
end
function c700000032.pccon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c700000032.pctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c700000032.pcop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1104,1)
		tc=g:GetNext()
	end
end
function c700000032.atktg(e,c)
	return c:GetCounter(0x1104)~=0
end
function c700000032.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local p=Duel.GetTurnPlayer()
	local ct=Duel.GetCounter(p,LOCATION_ONFIELD,0,0x1104)
	Duel.SetTargetPlayer(p)
	Duel.SetTargetParam(ct*400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,p,ct*400)
end
function c700000032.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c700000032.nbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,400) end
	Duel.PayLPCost(tp,400)
end
function c700000032.mgfilter(c,e,tp,sync)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE)
		and bit.band(c:GetReason(),0x80008)==0x80008 and c:GetReasonCard()==sync
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
		and c:IsCanBeEffectTarget(e)
end
function c700000032.nbtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local mg=c:GetMaterial()
	local ct=mg:GetCount()
	local sumtype=c:GetSummonType()
	if chkc then return false end
	if chk==0 then return sumtype==SUMMON_TYPE_SYNCHRO and ct>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE) and mg:FilterCount(c700000032.mgfilter,nil,e,tp,c)==ct end
	Duel.SetTargetCard(mg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,mg,mg:GetCount(),0,0)
end
function c700000032.nbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	if not c:IsRelateToEffect(e) or g:GetCount()~=tg:GetCount() then return end
	local fid=c:GetFieldID()
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(70000032,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=g:GetNext()
	end
	g:KeepAlive()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c700000032.damop2)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetOperation(c700000032.spop)
	e2:SetLabelObject(g)
	e2:SetLabel(g:GetCount())
	e2:SetValue(fid)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c700000032.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c700000032.spfilter(c,fid)
	return c:GetFlagEffectLabel(70000032)==fid
end
function c700000032.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=e:GetLabelObject()
	local tg=g:Filter(c700000032.spfilter,nil,e:GetValue())
	if not c:IsLocation(LOCATION_GRAVE) or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or tg:GetCount()~=e:GetLabel() then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	tg:AddCard(c)
	Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
