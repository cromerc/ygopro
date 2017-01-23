--No.107 銀河眼の時空竜 (Anime)
function c511010107.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetCondition(c511010107.regcon)
	e2:SetOperation(c511010107.regop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511010107,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0x1c0+TIMING_BATTLE_PHASE+TIMING_BATTLE_END,0x1c0+TIMING_BATTLE_PHASE+TIMING_BATTLE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c511010107.negcon)
	e3:SetCost(c511010107.negcost)
	e3:SetOperation(c511010107.negop)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
	--reset
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ADJUST)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c511010107.reset)
	e5:SetLabelObject(e1)
	c:RegisterEffect(e5)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010107.indes)
	c:RegisterEffect(e6)
	if not c511010107.global_check then
		c511010107.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010107.numchk)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ATTACK_DISABLED)
		ge3:SetOperation(c511010107.check)
		Duel.RegisterEffect(ge3,0)
	end
end
c511010107.xyz_number=107
function c511010107.check(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local cn=tc:GetFlagEffectLabel(511010107)
	if cn then
		tc:SetFlagEffectLabel(511010107,cn+1)
	else
		tc:RegisterFlagEffect(511010107,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,1)
	end
end
function c511010107.filter1(c)
	local cfn=c:GetFlagEffectLabel(511010107)
	   local cxm=c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)
    local cxa=c:GetEffectCount(EFFECT_EXTRA_ATTACK)
    if (cfn and cfn~=0) and (cxa and cxa>0) and (cxm and cxm>0) then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()+cfn) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and c:GetAttackAnnouncedCount()<=math.ceil(cxa+cxm)
    elseif (cfn and cfn~=0) and (cxa and cxa>0) and not cxm then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()+cfn) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and (c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0 and c:GetAttackAnnouncedCount()<=cxa)
    elseif (cfn and cfn~=0) and (cxm and cxm>0) and not cxa then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()+cfn) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and (c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0 and c:GetAttackAnnouncedCount()<=cxm)
    elseif (cfn and cfn~=0) and (not cxa and not cxm) then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()+cfn) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and (c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0 and c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0)
    elseif (cxa and cxa>0) and (cxm and cxm>0) and not cfn then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and c:GetAttackAnnouncedCount()<=math.ceil(cxa+cxm)
    elseif (cxa and cxa>0) and (not cfn and not cxm) then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and (c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0 and c:GetAttackAnnouncedCount()<=cxa)
    elseif (cxm and cxm>0) and (not cfn and not cxa) then
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and (c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0 and c:GetAttackAnnouncedCount()<=cxm)
    else
    return c:IsFaceup() and (c:GetAttackAnnouncedCount()==0 or c:GetAttackAnnouncedCount()~=c:GetBattledGroupCount()) and Duel.GetTurnPlayer()==c:GetControler() and (c:GetEffectCount(EFFECT_CANNOT_ATTACK)==0 and c:GetEffectCount(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0) and (c:IsAttackPos() or c:GetEffectCount(EFFECT_DEFENCE_ATTACK)==1) and (c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0 and c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0)
    end
end
function c511010107.negcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511010107.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil) 
	if g:GetCount()~=0 then
	return Duel.GetCurrentPhase()==PHASE_BATTLE
	else
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
	end
end
function c511010107.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010107.filter2(c)
	return c:IsFaceup() and (c:GetAttack()~=c:GetBaseAttack() or c:GetDefense()~=c:GetBaseDefense())
end
function c511010107.filter3(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c511010107.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511010107.filter3,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	g=Duel.GetMatchingGroup(c511010107.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	tc=g:GetFirst()
	while tc do
		if tc:GetAttack()~=tc:GetBaseAttack() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(tc:GetBaseAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		if tc:GetDefense()~=tc:GetBaseDefense() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
			e1:SetValue(tc:GetBaseDefense())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
	if c:IsFaceup() and c:IsRelateToEffect(e) then
	local ct=e:GetLabelObject():GetLabel()
	local atk=math.ceil(ct*1000)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	if Duel.GetTurnPlayer()==tp then
	local val=math.max(c:GetEffectCount(EFFECT_EXTRA_ATTACK)+1,c:GetAttackAnnouncedCount())
	if c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)>0 then
	local val=math.max(c:GetEffectCount(EFFECT_EXTRA_ATTACK)+c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)+1,c:GetAttackAnnouncedCount())
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(val)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e2)
	end
	end
end
function c511010107.regcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end

function c511010107.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabelObject():GetLabel()
	e:GetLabelObject():SetLabel(ct+1)
end
function c511010107.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,88177324)
	Duel.CreateToken(1-tp,88177324)
end
function c511010107.indes(e,c)
return not c:IsSetCard(0x48)
end
function c511010107.reset(e,tp,eg,ep,ev,re,r,rp,chk)
	e:GetLabelObject():SetLabel(0)
end
