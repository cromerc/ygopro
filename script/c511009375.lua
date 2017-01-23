--Magical Silk Hat
function c511009375.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511009375.condition)
	e1:SetTarget(c511009375.target)
	e1:SetOperation(c511009375.activate)
	c:RegisterEffect(e1)
end
function c511009375.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511009375.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),nil,0x11,0,0,1,RACE_SPELLCASTER,ATTRIBUTE_LIGHT,POS_FACEDOWN)
	-- and Duel.IsExistingMatchingCard(c511009375.stfilter,tp,LOCATION_HAND,0,1,c,e,tp)
	and Duel.IsExistingMatchingCard(c511009375.stfilter,tp,LOCATION_HAND,0,1,c)
end
function c511009375.stfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) 
end
function c511009375.stfilter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),nil,0x11,0,0,1,RACE_SPELLCASTER,ATTRIBUTE_LIGHT,POS_FACEDOWN)
end
function c511009375.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009375.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		-- and Duel.IsExistingMatchingCard(c511009375.stfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c511009375.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g1=Duel.GetMatchingGroup(c511009375.filter,tp,LOCATION_HAND,0,nil,e,tp)
	-- Duel.SelectTarget(tp,c19441018.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local g2=Duel.GetMatchingGroup(c511009375.stfilter2,tp,LOCATION_HAND,0,g1:GetFirst(),e,tp)
	if g1:GetCount()+g2:GetCount()<2 then return end
	local g=Group.CreateGroup()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=g1:Select(tp,1,1,nil)
	
	local tg=sg1:GetFirst()
	local fid=e:GetHandler():GetFieldID()
	local c=e:GetHandler()
	while tg do
		local e1=Effect.CreateEffect(tg)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x47c0000)
		tg:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RACE)
		e2:SetValue(RACE_SPELLCASTER)
		tg:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e3:SetValue(ATTRIBUTE_LIGHT)
		tg:RegisterEffect(e3,true)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_SET_BASE_ATTACK)
		e4:SetValue(0)
		tg:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_SET_BASE_DEFENSE)
		e5:SetValue(0)
		tg:RegisterEffect(e5,true)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CHANGE_LEVEL)
		e6:SetValue(1)
		tg:RegisterEffect(e6,true)
		tg:RegisterFlagEffect(81210420,RESET_EVENT+0x47c0000+RESET_PHASE+PHASE_BATTLE,0,1,fid)
		
		--change target
		local e9=Effect.CreateEffect(c)
		e9:SetDescription(aux.Stringid(54912977,0))
		e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e9:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e9:SetCode(EVENT_BATTLE_CONFIRM)
		e9:SetCondition(c511009375.cond)
		-- e9:SetTarget(c511009375.tg)
		e9:SetOperation(c511009375.op)
		tg:RegisterEffect(e9,true)
		
		tg=sg1:GetNext()
	end
	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg2=g2:Select(tp,1,1,nil)
	
	local tg=sg2:GetFirst()
	local fid=e:GetHandler():GetFieldID()
	while tg do
		
		local e1=Effect.CreateEffect(tg)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x47c0000)
		tg:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RACE)
		e2:SetValue(RACE_SPELLCASTER)
		tg:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e3:SetValue(ATTRIBUTE_LIGHT)
		tg:RegisterEffect(e3,true)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_SET_BASE_ATTACK)
		e4:SetValue(0)
		tg:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_SET_BASE_DEFENSE)
		e5:SetValue(0)
		tg:RegisterEffect(e5,true)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CHANGE_LEVEL)
		e6:SetValue(1)
		tg:RegisterEffect(e6,true)
		tg:RegisterFlagEffect(81210420,RESET_EVENT+0x47c0000+RESET_PHASE+PHASE_BATTLE,0,1,fid)
		
		--change target
		local e9=Effect.CreateEffect(c)
		e9:SetDescription(aux.Stringid(54912977,0))
		e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e9:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e9:SetCode(EVENT_BATTLE_CONFIRM)
		e9:SetCondition(c511009375.cond)
		-- e9:SetTarget(c511009375.tg)
		e9:SetOperation(c511009375.op)
		tg:RegisterEffect(e9,true)
	
		
		tg=sg2:GetNext()
	end
	g:Merge(sg1)
	g:Merge(sg2)

	Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEDOWN_ATTACK)
	Duel.ShuffleSetCard(g)
	g:KeepAlive()
	
	local de=Effect.CreateEffect(e:GetHandler())
	de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	de:SetCode(EVENT_PHASE+PHASE_BATTLE)
	de:SetReset(RESET_PHASE+PHASE_BATTLE)
	de:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	de:SetCountLimit(1)
	de:SetLabel(fid)
	de:SetLabelObject(g)
	de:SetOperation(c511009375.desop)
	Duel.RegisterEffect(de,tp)
	
	
	-- atklimit
	--cannot attack
	local e10=Effect.CreateEffect(e:GetHandler())
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	-- e3:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(0,LOCATION_MZONE)
	e10:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e10:SetReset(RESET_PHASE+PHASE_END)
	e10:SetCondition(c511009375.atkcon)
	e10:SetTarget(c511009375.atktg)
	Duel.RegisterEffect(e10,tp)
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_ATTACK_ANNOUNCE)
	-- e4:SetRange(LOCATION_MZONE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e11:SetReset(RESET_PHASE+PHASE_END)
	e11:SetOperation(c511009375.checkop)
	e11:SetLabelObject(e10)
	Duel.RegisterEffect(e11,tp)
	
end
function c511009375.desfilter(c,fid)
	return c:GetFlagEffectLabel(81210420)==fid
end
function c511009375.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local fid=e:GetLabel()
	local tg=g:Filter(c511009375.desfilter,nil,fid)
	g:DeleteGroup()
	Duel.Destroy(tg,REASON_EFFECT)
	local tg2=tg:Filter(c511009375.desfilter,nil,fid)
	Duel.SendtoGrave(tg2,REASON_EFFECT)
end

function c511009375.cond(e,tp,eg,ep,ev,re,r,rp)
	return r~=REASON_REPLACE and Duel.GetAttackTarget()==e:GetHandler() and Duel.GetAttacker():IsControler(1-tp)
end
function c511009375.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if bit.band(c:GetOriginalType(),TYPE_MONSTER)==TYPE_MONSTER then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e1:SetOperation(c511009375.rdop1)
		c:RegisterEffect(e1)
	elseif bit.band(c:GetOriginalType(),TYPE_SPELL)==TYPE_SPELL or bit.band(c:GetOriginalType(),TYPE_TRAP)==TYPE_TRAP then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e1:SetOperation(c511009375.rdop2)
		c:RegisterEffect(e1)
	end
end
function c511009375.rdop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
function c511009375.rdop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
end


-- atklimit
function c511009375.atkcon(e)
	return e:GetHandler():GetFlagEffect(511009375)~=0
end
function c511009375.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel()
end
function c511009375.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511009375)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	e:GetHandler():RegisterFlagEffect(511009375,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end