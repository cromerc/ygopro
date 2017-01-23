--Infection Medium
--インフェクション・ミーディアム
--  By Shad3

local scard=c511005083
local s_id=511005083
local t_id=511005082
local _str=4001

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetCondition(scard.cd)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
	--Can't Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(scard.nosum_tg)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e3)
	--IBToken Destroyed
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e4:SetDescription(aux.Stringid(_str,15))
	e4:SetCondition(scard.des_cd)
	e4:SetTarget(scard.des_tg)
	e4:SetOperation(scard.des_op)
	c:RegisterEffect(e4)
	--Global check
	if not scard.gl_chk then
		scard.gl_chk=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_LEAVE_FIELD)
		ge1:SetOperation(scard.reg_op)
		Duel.RegisterEffect(ge1,0)
	end
end

function scard.reg_op(e,tp,eg,ep,ev,re,r,rp)
		local c=eg:GetFirst()
		while c do
			if c:IsReason(REASON_DESTROY) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_XYZ) and c:IsRace(RACE_FIEND) then
				Duel.RegisterFlagEffect(c:GetPreviousControler(),s_id,RESET_PHASE+PHASE_END,0,1)
			end
			c=eg:GetNext()
		end
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,s_id)~=0
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local gc=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	if chk==0 then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then return false end --spiritdragon
		if gc==0 then return false end
		return Duel.IsPlayerCanSpecialSummonMonster(tp,t_id,0,0x4011,300,300,1,RACE_FIEND,ATTRIBUTE_DARK) and Duel.GetLocationCount(tp,LOCATION_MZONE)+gc>4
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,gc,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,5,tp,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end --spiritdragon
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	if Duel.Destroy(g,REASON_EFFECT)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>4 then
		for i=1,5 do
			local tc=Duel.CreateToken(tp,t_id)
			if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
				e1:SetOperation(scard.dam_op)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
			end
		end
		Duel.SpecialSummonComplete()
	end
end

function scard.dam_op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(_str,14)) then
		Duel.ChangeBattleDamage(tp,0)
		Duel.ChangeBattleDamage(1-tp,0)
	end
end

function scard.nosum_tg(e,c)
	return c:IsLocation(LOCATION_HAND)
end

function scard.des_cd(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCode,1,nil,t_id)
end

function scard.des_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetFieldGroup(tp,0,LOCATION_MZONE),1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end

function scard.des_op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local tc=Duel.GetFieldGroup(tp,0,LOCATION_MZONE):Select(tp,1,1,nil):GetFirst()
		if tc and Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,300,REASON_EFFECT)
		end
	end
end