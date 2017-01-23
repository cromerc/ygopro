--CNo.5 亡朧龍カオス・キマイラ・ドラゴン (Anime)
function c511010205.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,3,nil,nil,5)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511010205.atkval)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c511010205.atcon)
	c:RegisterEffect(e2)
	--multiple attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(c511010205.atkvalue)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetDescription(aux.Stringid(511010205,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c511010205.atkcost)
	e4:SetCondition(c511010205.atkcon)
	e4:SetTarget(c511010205.atktg)
	e4:SetOperation(c511010205.atkop)
	c:RegisterEffect(e4)
	--halve atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_DAMAGE_CALCULATING)
	e5:SetCondition(c511010205.halfcon)
	e5:SetOperation(c511010205.halfop)
	c:RegisterEffect(e5)
	--back to deck
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetDescription(aux.Stringid(511010205,1))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetCountLimit(1)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTarget(c511010205.tdtg)
	e6:SetOperation(c511010205.tdop)
	c:RegisterEffect(e6)
	--atk reset
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_MZONE)
	e7:SetOperation(c511010205.resetop)
	c:RegisterEffect(e7)
	--reattach
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(511010205,2))
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c511010205.reattcon)
	e8:SetCost(c511010205.reattcost)
	e8:SetTarget(c511010205.reatttg)
	e8:SetOperation(c511010205.reattop)
	c:RegisterEffect(e8)
	--Rank Up Check
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	e9:SetCondition(c511010205.rankupregcon)
	e9:SetOperation(c511010205.rankupregop)
	c:RegisterEffect(e9)
	--battle indestructable
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e10:SetValue(c511010205.indes)
	c:RegisterEffect(e10)
	if not c511010205.global_check then
		c511010205.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010205.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010205.xyz_number=5
function c511010205.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c511010205.atcon(e)
	return e:GetHandler():GetFlagEffect(511010205)==0
end
function c511010205.atkvalue(e,c)
	return e:GetHandler():GetFlagEffect(511010205)-1
end
function c511010205.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetOverlayGroup()
	if chk==0 then return g:GetCount()>0 end
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_COST)
	Duel.RaiseSingleEvent(e:GetHandler(),EVENT_DETACH_MATERIAL,e,0,0,0,0)
	sg:GetFirst():RegisterFlagEffect(511205,RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,0,0)
end
function c511010205.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511010205.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_DECK,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c511010205.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_DECK,nil):RandomSelect(tp,1)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	g:GetFirst():RegisterFlagEffect(5110205,RESET_PHASE+PHASE_END,0,0)
	e:GetHandler():RegisterFlagEffect(511010205,RESET_EVENT+0x1ff0000,0,0)
end
function c511010205.halfcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil
end
function c511010205.halfop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(c:GetAttack()/2)
	c:RegisterEffect(e1)
end
function c511010205.tdfilter(c)
	return c:IsAbleToDeck() and c:GetFlagEffect(5110205)~=0
end
function c511010205.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511010205.tdfilter,tp,0,LOCATION_REMOVED,1,nil) end
	local g=Duel.GetMatchingGroup(c511010205.tdfilter,tp,0,LOCATION_REMOVED,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c511010205.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511010205.tdfilter,tp,0,LOCATION_REMOVED,nil)
	Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	Duel.SortDecktop(tp,1-tp,g:GetCount())
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_FORBIDDEN)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_ACTIVATE)
		tc:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_TRIGGER)
		tc:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e5)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CANNOT_SUMMON)
		tc:RegisterEffect(e6)
		local e7=e1:Clone()
		e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		tc:RegisterEffect(e7)
		local e8=e1:Clone()
		e8:SetCode(EFFECT_CANNOT_MSET)
		tc:RegisterEffect(e8)
		local e9=e1:Clone()
		e9:SetCode(EFFECT_CANNOT_SSET)
		tc:RegisterEffect(e9)
		tc=g:GetNext()
	end
end
function c511010205.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():ResetFlagEffect(511010205)
end
function c511010205.reattcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511010205.reattcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511010205.reattfilter(c)
	return c:GetFlagEffect(511205)~=0
end
function c511010205.reatttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511010205.reattfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	local g=Duel.GetMatchingGroup(c511010205.reattfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,g:GetCount(),tp,0)
end
function c511010205.reattop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511010205.reattfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	if g:GetCount()>0 then
		Duel.Overlay(e:GetHandler(),g)
	end
end
function c511010205.rumfilter(c)
	return c:IsCode(511010005) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end

function c511010205.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and rc:IsSetCard(0x95) and e:GetHandler():GetMaterial():IsExists(c511010205.rumfilter,1,nil)
end
function c511010205.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--material
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(511010205,3))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetTarget(c511010205.mattg)
	e9:SetOperation(c511010205.matop)
	e9:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e9)
end

function c511010205.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,nil) end
end
function c511010205.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c511010205.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,69757518)
	Duel.CreateToken(1-tp,69757518)
end
function c511010205.indes(e,c)
return not c:IsSetCard(0x48)
end