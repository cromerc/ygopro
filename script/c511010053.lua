--No.53 偽骸神 Heart－eartH
--fixed by MLD
function c511010053.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--Immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511010053.efilter)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010053.indes)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(876330,0))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c511010053.eqtg)
	e3:SetOperation(c511010053.eqop)
	c:RegisterEffect(e3)
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetTarget(c511010053.desreptg)
	e4:SetOperation(c511010053.desrepop)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511010053,2))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(511010053)
	e5:SetTarget(c511010053.damtg)
	e5:SetOperation(c511010053.damop)
	c:RegisterEffect(e5)
	--recover
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(3701074,0))
	e6:SetCategory(CATEGORY_RECOVER)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(511010054)
	e6:SetCost(c511010053.bdcost)
	e6:SetTarget(c511010053.rectg)
	e6:SetOperation(c511010053.recop)
	c:RegisterEffect(e6)
	--battle damage
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(93730230,0))
	e7:SetCategory(CATEGORY_DAMAGE)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_BATTLE_DAMAGE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCondition(c511010053.bdcon)
	e7:SetCost(c511010053.bdcost)
	e7:SetTarget(c511010053.bdtg)
	e7:SetOperation(c511010053.bdop)
	c:RegisterEffect(e7)
	--93 Summon
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(64414267,0))
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_BE_BATTLE_TARGET)
	e8:SetCondition(c511010053.xyzcon)
	e8:SetTarget(c511010053.xyztg)
	e8:SetOperation(c511010053.xyzop)
	c:RegisterEffect(e8)
	if not c511010053.global_check then
		c511010053.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010053.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010053.xyz_number=53
function c511010053.efilter(e,re)
	return e:GetHandlerPlayer()~=re:GetHandlerPlayer()
end
function c511010053.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c511010053.eqfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c511010053.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511010053.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511010053.eqfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511010053.eqfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511010053.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local a=Duel.GetAttacker()
	if tc and tc:IsRelateToEffect(e) and c:IsFaceup() and c:IsRelateToEffect(e) and a and a:IsRelateToBattle() then
		if not Duel.Equip(tp,tc,c) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511010053.eqlimit)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(a:GetAttack())
		tc:RegisterEffect(e2)
		tc:RegisterFlagEffect(511010053,RESET_EVENT+0x1fe0000,0,0)
	end
end
function c511010053.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511010053.repfilter(c,ec)
	return c:GetEquipTarget()==ec and c:IsAbleToGrave() and c:GetFlagEffect(511010053)>0
end
function c511010053.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511010053.repfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil,c)
	if chk==0 then return c:IsReason(REASON_BATTLE) and g:GetCount()>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(63465535,1)) then
		local atk=c:GetAttack()
		e:SetLabel(atk)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
function c511010053.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local atk1=e:GetLabel()
	local atk2=e:GetHandler():GetAttack()
	local dif=atk1-atk2
	Duel.RaiseSingleEvent(e:GetHandler(),511010053,e,r,rp,ep,dif)
end
function c511010053.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ev/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ev/2)
end
function c511010053.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	Duel.RaiseSingleEvent(e:GetHandler(),511010054,e,r,rp,ep,d)
end
function c511010053.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c511010053.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c511010053.bdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511010053.bdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010053.bdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ev/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ev/2)
end
function c511010053.bdop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511010053.xyzcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()==0
end
function c511010053.xyzfilter(c,e,tp)
	return e:GetHandler():IsCanBeXyzMaterial(c) and c:IsCode(97403510)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511010053.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511010053.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511010053.xyzop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511010053.xyzfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c511010053.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,23998625)
	Duel.CreateToken(1-tp,23998625)
end
