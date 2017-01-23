--CNo.73 激瀧瀑神アビス・スープラ
function c511010173.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,3)
	c:EnableReviveLimit()
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010173,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010173.atkcon)
	e1:SetCost(c511010173.atkcost)
	e1:SetOperation(c511010173.atkop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010173.indes)
	c:RegisterEffect(e6)
	if not c511010173.global_check then
		c511010173.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010173.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010173.xyz_number=73
function c511010173.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsControler(1-tp)
end
function c511010173.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and c:GetFlagEffect(511010173)==0 end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
	c:RegisterFlagEffect(511010173,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511010173.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsRelateToBattle() and c:IsFaceup() and bc:IsRelateToBattle() and bc:IsFaceup() then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(bc:GetAttack())
	c:RegisterEffect(e1)
		end
end
function c511010173.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,96864105)
	Duel.CreateToken(1-tp,96864105)
end
function c511010173.indes(e,c)
return not c:IsSetCard(0x48)
end


