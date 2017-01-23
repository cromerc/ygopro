--Number C6: Chronomaly Chaos Atlandis (Anime)
function c511001781.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001781.rankupregcon)
	e1:SetOperation(c511001781.rankupregop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e7:SetValue(c511001781.indes)
	c:RegisterEffect(e7)
	if not c511001781.global_check then
		c511001781.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001781.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001781.xyz_number=6
function c511001781.rumfilter(c)
	return c:IsCode(9161357) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511001781.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511001781.rumfilter,1,nil)
end
function c511001781.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(876330,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511001781.eqtg)
	e1:SetOperation(c511001781.eqop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--equip 2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32559361,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetTarget(c511001781.eqtg2)
	e2:SetOperation(c511001781.eqop)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c511001781.val)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(16037007,0))
	e4:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c511001781.discon)
	e4:SetCost(c511001781.discost)
	e4:SetTarget(c511001781.distg)
	e4:SetOperation(c511001781.disop)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e4)
	--lp 1
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(84926738,1))
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511001781.lpcon)
	e5:SetCost(c511001781.lpcost)
	e5:SetTarget(c511001781.lptg)
	e5:SetOperation(c511001781.lpop)
	e5:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(38107923,1))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetCondition(c511001781.spcon)
	e6:SetTarget(c511001781.sptg)
	e6:SetOperation(c511001781.spop)
	e6:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e6)
end
function c511001781.eqfilter(c,tp)
	return c:IsSetCard(0x7f) and (c:IsAbleToChangeControler() or c:IsControler(tp))
end
function c511001781.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001781.eqfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511001781.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511001781.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511001781.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) and tc~=c then
			if not Duel.Equip(tp,tc,c,false) then return end
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511001781.eqlimit)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001781,RESET_EVENT+0x1fe0000,0,0)
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
function c511001781.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511001781.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and not tc:IsType(TYPE_TOKEN) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and tc:IsAbleToChangeControler() and not c:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsOnField() end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,tc,1,0,0)
end
function c511001781.eqtc(c)
	return c:GetFlagEffect(511001781)>0
end
function c511001781.val(e,c)
	return c:GetEquipGroup():FilterCount(c511001781.eqtc,nil)*1000
end
function c511001781.discon(e,tp,eg,ep,ev,re,r,rp)
	if not c511001781.eqcon(e,tp,eg,ep,ev,re,r,rp) then return false end
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(e:GetHandler()) and Duel.IsChainDisablable(ev)
end
function c511001781.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipGroup():IsExists(Card.IsAbleToGraveAsCost,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=e:GetHandler():GetEquipGroup():FilterSelect(tp,Card.IsAbleToGraveAsCost,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511001781.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511001781.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c511001781.lpcon(e,tp,eg,ep,ev,re,r,rp)
	if not c511001781.eqcon(e,tp,eg,ep,ev,re,r,rp) then return false end
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_CHAINING,true)
	if res and tre then
		if tre==e then return false end
	end
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c511001781.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(1-tp)~=1 end
end
function c511001781.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,3,REASON_COST) end
	local ov=c:GetOverlayGroup()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local sg=ov:Select(tp,3,3,nil)
	Duel.SendtoGrave(sg,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511001781.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,1)
end
function c511001781.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return tp==Duel.GetTurnPlayer() and c:GetOverlayCount()==0
end
function c511001781.spfilter(c,e,tp,mc)
	return c:IsCode(9161357) and mc:IsCanBeXyzMaterial(c) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,true)
end
function c511001781.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingMatchingCard(c511001781.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511001781.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001781.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c)
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,true,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c511001781.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,6387204)
	Duel.CreateToken(1-tp,6387204)
end
function c511001781.indes(e,c)
	return not c:IsSetCard(0x48)
end
