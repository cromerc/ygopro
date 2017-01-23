--Number 103: Ragnazero (Anime)
function c511010103.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94380860,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(511010103)
	e1:SetCountLimit(1)
	e1:SetCost(c511010103.cost)
	e1:SetTarget(c511010103.destg)
	e1:SetOperation(c511010103.desop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010103.indes)
	c:RegisterEffect(e2)
if not c511010103.global_check then
		c511010103.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010103.numchk)
		Duel.RegisterEffect(ge2,0)
		--register
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge3:SetOperation(c511010103.atkregoperation)
		Duel.RegisterEffect(ge3,0)
	end
end
c511010103.xyz_number=103
--atk change check
function c511010103.atkregoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511010103)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511010103.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511010103,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end
end
function c511010103.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	if e:GetLabel()~=c:GetAttack() then
		Duel.RaiseEvent(c,511010103,re,REASON_EFFECT,rp,tp,1)
	end
	e:SetLabel(c:GetAttack())
end
function c511010103.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010103.desfilter(c,e,tp)
	return c:GetAttack()<c:GetBaseAttack() and c:IsControler(1-tp) and c:IsCanBeEffectTarget(e) and c:IsDestructable(e)
end
function c511010103.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return eg:IsExists(c511010103.desfilter,1,nil,e,tp) and Duel.IsPlayerCanDraw(tp,1) end
	if eg:GetCount()==1 then
		Duel.SetTargetCard(eg)
	else
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=eg:FilterSelect(tp,c511010103.desfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511010103.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c511010103.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,94380860)
	Duel.CreateToken(1-tp,94380860)
end
function c511010103.indes(e,c)
return not c:IsSetCard(0x48)
end