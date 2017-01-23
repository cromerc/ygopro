--Obelisk the Tormentor
--マイケル・ローレンス・ディーによってスクリプト
function c511000235.initial_effect(c)
	--Summon with 3 Tribute
	c:SetUniqueOnField(1,0,511000235)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000235.sumoncon)
	e1:SetOperation(c511000235.sumonop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c511000235.setcon)
	c:RegisterEffect(e2)
	--Summon Cannot be Negated
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c511000235.sumsuc)
	c:RegisterEffect(e4)
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e5)
	--release limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UNRELEASABLE_SUM)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c511000235.recon)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCondition(c511000235.recon2)
	e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e7)
	--cannot be target
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(c511000235.tgfilter)
	c:RegisterEffect(e8)
	--immune spell
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(c511000235.efilter)
	c:RegisterEffect(e11)
	--ATK/DEF effects are only applied until the End Phase
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_REPEAT)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EVENT_PHASE+PHASE_END)
	e13:SetCountLimit(1)
	e13:SetOperation(c511000235.atkdefresetop)
	c:RegisterEffect(e13)
	--Race "Warrior"
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_ADD_RACE)
	e14:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e14)
	--If Special Summoned: Send to Grave
	local e16=Effect.CreateEffect(c)
	e16:SetDescription(aux.Stringid(511000235,1))
	e16:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE+CATEGORY_TOHAND+CATEGORY_TODECK)
	e16:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e16:SetRange(LOCATION_MZONE)
	e16:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e16:SetCountLimit(1)
	e16:SetCode(EVENT_PHASE+PHASE_END)
	e16:SetCondition(c511000235.stgcon)
	e16:SetTarget(c511000235.stgtg)
	e16:SetOperation(c511000235.stgop)
	c:RegisterEffect(e16)
	--FINISH IT
	local e17=Effect.CreateEffect(c)
	e17:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e17:SetDescription(aux.Stringid(511000235,2))
	e17:SetCategory(CATEGORY_DESTROY)
	e17:SetType(EFFECT_TYPE_QUICK_O)
	e17:SetCode(EVENT_FREE_CHAIN)
	e17:SetRange(LOCATION_MZONE)
	e17:SetCost(c511000235.atkcost)
	e17:SetCondition(c511000235.atkcon)
	e17:SetTarget(c511000235.atktg)
	e17:SetOperation(c511000235.atkop)
	c:RegisterEffect(e17)
	--indestructable
	local e18=Effect.CreateEffect(c)
	e18:SetType(EFFECT_TYPE_SINGLE)
	e18:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e18:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e18:SetRange(LOCATION_MZONE)
	e18:SetValue(c511000235.indes)
	c:RegisterEffect(e18)
	--redirect attack
	local red=Effect.CreateEffect(c)
	red:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	red:SetCode(EVENT_SPSUMMON_SUCCESS)
	red:SetOperation(c511000235.redatk)
	c:RegisterEffect(red)
end
function c511000235.indes(e,re,rp)
	return not re:GetOwner():IsCode(10000010)
end
function c511000235.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c511000235.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c511000235.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000235.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000235.setcon(e,c)
	if not c then return true end
	return false
end
function c511000235.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c511000235.chainlm)
end
function c511000235.chainlm(e,rp,tp)
	return e:GetHandler():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000235.efilter(e,te)
	return te:GetOwner()~=e:GetOwner() and te:IsActiveType(TYPE_EFFECT) and not te:GetOwner():IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000235.tgfilter(e,re)
	if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end
function c511000235.stgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511000235.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	if c:IsPreviousLocation(LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_DECK) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_HAND) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_REMOVED) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
	end
end
function c511000235.stgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if c:IsPreviousLocation(LOCATION_GRAVE) then
			Duel.SendtoGrave(c,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_DECK) then
			Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_HAND) then
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_REMOVED) then
			Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c511000235.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card)
end
function c511000235.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e2:SetValue(c:GetBaseDefense())
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local eqg=c:GetEquipGroup()
	local tgg=Duel.GetMatchingGroup(c511000235.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
	eqg:Merge(tgg)
	if eqg:GetCount()>0 then
		Duel.Destroy(eqg,REASON_EFFECT)
	end
end
function c511000235.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c511000235.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE and e:GetHandler():IsAttackable()
end
function c511000235.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511000235.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(sg,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE+PHASE_END)
		e1:SetValue(99999999)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetCondition(c511000235.damcon)
		e2:SetOperation(c511000235.damop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE+PHASE_END)
		c:RegisterEffect(e2)
		if Duel.GetTurnPlayer()==tp then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_FIRST_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE+PHASE_END)
			c:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_MUST_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE+PHASE_END)
			c:RegisterEffect(e2)
		else
			local tg=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
			Duel.CalculateDamage(c,tg)
		end
	end
end
function c511000235.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511000235.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,Duel.GetLP(ep)*100)
end
function c511000235.redatk(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and a and a:IsControler(1-tp) and Duel.GetAttackTarget() then
		Duel.ChangeAttackTarget(e:GetHandler())
	end
end
--MLD
