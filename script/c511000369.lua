--Number 100: Numeron Dragon
--By Edo9300
--atkup fixed by eclair
--forced trigger fixed by MLD
function c511000369.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000369,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511000369.spcon)
	e1:SetTarget(c511000369.sptg)
	e1:SetOperation(c511000369.spop)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511000369.atkop)
	c:RegisterEffect(e2)
	--destroy and return
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000369,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c511000369.destg)
	e3:SetOperation(c511000369.desop)
	c:RegisterEffect(e3)
	--attack up
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetDescription(aux.Stringid(511000369,2))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c511000369.regcost)
	e4:SetOperation(c511000369.regop)
	c:RegisterEffect(e4)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511000369.indes)
	c:RegisterEffect(e5)
	if not c511000369.global_check then
		c511000369.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge1:SetTarget(c511000369.stcheck)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511000369.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511000369.xyz_number=100
function c511000369.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,57314798)
	Duel.CreateToken(1-tp,57314798)
end
function c511000369.spcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and at:IsType(TYPE_XYZ) and Duel.GetAttackTarget()==nil and Duel.GetFieldGroupCount(tp,LOCATION_HAND+LOCATION_ONFIELD,0)==0
end
function c511000369.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511000369.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000369.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
end
function c511000369.retfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:GetFlagEffect(511000369)>0
end
function c511000369.retfilter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:GetFlagEffect(511000369)>0 
		and not Duel.IsExistingMatchingCard(function(c,seq)return c:GetSequence()==seq end,tp,LOCATION_SZONE,0,1,c,c:GetFlagEffectLabel(511000370))
end
function c511000369.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg1=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg1,sg1:GetCount(),0,0)
	local sg2=Duel.GetMatchingGroup(c511000369.retfilter,tp,0x32,0x32,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,sg2,sg2:GetCount(),0,0)
end
function c511000369.fil(c,seq,p)
	return c:GetFlagEffectLabel(511000370)==seq and c:GetFlagEffectLabel(511000371)==p
end
function c511000369.fil2(c,seq,p)
	return c:IsFaceup() and not (c:IsType(TYPE_FIELD+TYPE_CONTINUOUS) or c:IsHasEffect(EFFECT_REMAIN_FIELD))
end
function c511000369.transchk(c)
	return c:GetFlagEffectLabel(511000368)==0
end
function c511000369.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg1=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(sg1,REASON_EFFECT)
	local sg2=Duel.GetMatchingGroup(c511000369.retfilter2,tp,0x32,0x32,nil)
	--if sg2:IsExists(c511000369.transchk,1,nil) then return end
	local tc=sg2:GetFirst()
	while tc do
		local sgf=sg2:Filter(c511000369.fil,nil,tc:GetFlagEffectLabel(511000370),tc:GetFlagEffectLabel(511000371))
		if sgf:GetCount()>1 then
			tc=sgf:Select(tc:GetFlagEffectLabel(511000371),1,1,nil):GetFirst()
			sg2:Remove(c511000369.fil,nil,tc:GetFlagEffectLabel(511000370),tc:GetFlagEffectLabel(511000371))
		end
		Duel.MoveToField(tc,tp,tc:GetFlagEffectLabel(511000371),LOCATION_SZONE,tc:GetFlagEffectLabel(511000369),true)
		Duel.MoveSequence(tc,tc:GetFlagEffectLabel(511000370))
		tc=sg2:GetNext()
	end
	Duel.SendtoGrave(sg2:Filter(c511000369.fil2,nil),REASON_RULE)
end
function c511000369.regcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000369.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetOperation(c511000369.atkupop)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511000369.atkupop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local atk=g:GetSum(Card.GetRank)*1000
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(atk)
	c:RegisterEffect(e1)
end
function c511000369.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c511000369.stcheck(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsType,nil,TYPE_SPELL+TYPE_TRAP)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			tc:RegisterFlagEffect(511000369,RESET_PHASE+PHASE_END,0,1,tc:GetPreviousPosition())
			tc:RegisterFlagEffect(511000370,RESET_PHASE+PHASE_END,0,1,tc:GetPreviousSequence())
			tc:RegisterFlagEffect(511000371,RESET_PHASE+PHASE_END,0,1,tc:GetPreviousControler())
			tc=g:GetNext()
		end
	end
end
